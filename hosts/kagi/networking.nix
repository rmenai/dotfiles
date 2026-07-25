{ lib, ... }:
let
  cloudflareIpsV4 = [
    "173.245.48.0/20"
    "103.21.244.0/22"
    "103.22.200.0/22"
    "103.31.4.0/22"
    "141.101.64.0/18"
    "108.162.192.0/18"
    "190.93.240.0/20"
    "188.114.96.0/20"
    "197.234.240.0/22"
    "198.41.128.0/17"
    "162.158.0.0/15"
    "104.16.0.0/13"
    "104.24.0.0/14"
    "172.64.0.0/13"
    "131.0.72.0/22"
  ];

  cloudflareIpsV6 = [
    "2400:cb00::/32"
    "2606:4700::/32"
    "2803:f800::/32"
    "2405:b500::/32"
    "2405:8100::/32"
    "2a06:98c0::/29"
    "2c0f:f248::/32"
  ];
in
{
  networking = {
    hostName = "kagi";
    useNetworkd = true;
    useDHCP = false;

    firewall = {
      enable = true;
      allowPing = false;
      trustedInterfaces = [ "tailscale0" ];

      allowedTCPPorts = lib.mkForce [ ];
      allowedUDPPorts = lib.mkForce [
        41641 # Tailscale
        51820 # Wireguard
      ];

      # Whitelist http traffic only for cloudflare ip ranges
      extraInputRules = ''
        ${lib.concatMapStringsSep "\n" (ip: "ip saddr ${ip} tcp dport { 80, 443 } accept") cloudflareIpsV4}
        ${lib.concatMapStringsSep "\n" (ip: "ip6 saddr ${ip} tcp dport { 80, 443 } accept") cloudflareIpsV6}
      '';
    };
  };

  systemd.network = {
    enable = true;
    networks."10-wan" = {
      matchConfig.Name = "en* eth*";
      networkConfig.DHCP = "yes";
    };
  };
}
