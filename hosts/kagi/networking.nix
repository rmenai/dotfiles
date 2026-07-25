{
  config,
  lib,
  pkgs,
  ...
}:
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
  sops.secrets = {
    "secrets/wireguard_private_key" = {
      owner = "root";
      group = "systemd-network";
      mode = "0440";
    };

    "secrets/smb_freebox" = {
      owner = "root";
      mode = "0400";
    };
  };

  networking = {
    hostName = "kagi";
    useNetworkd = true;
    useDHCP = false;

    firewall = {
      enable = true;
      allowPing = false;

      trustedInterfaces = [
        "tailscale0"
        "wg0"
      ];

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

  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;

  systemd.network = {
    enable = true;

    networks."10-wan" = {
      matchConfig.Name = "en* eth*";
      networkConfig.DHCP = "yes";
    };

    networks."50-wg0" = {
      matchConfig.Name = "wg0";
      address = [ "192.168.27.65/32" ];
    };

    netdevs."50-wg0" = {
      netdevConfig = {
        Kind = "wireguard";
        Name = "wg0";
        MTUBytes = "1360";
      };

      wireguardConfig = {
        ListenPort = 51820;
        PrivateKeyFile = config.sops.secrets."secrets/wireguard_private_key".path;
        RouteTable = "main";
      };

      wireguardPeers = [
        {
          PublicKey = "vPjm0BwUFKWAApEgCZRDtDII0RS7yDfO/jYixqiHIUo=";
          Endpoint = "${config.private.freeboxIP}:51820";
          AllowedIPs = [
            "192.168.27.64/32"
            "192.168.1.0/24"
          ];
          PersistentKeepalive = 25;
        }
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    wireguard-tools
    cifs-utils
    tcpdump
  ];

  fileSystems."/mnt/data" = {
    device = "//192.168.1.254/Data";
    fsType = "cifs";
    options = [
      "credentials=${config.sops.secrets."secrets/smb_freebox".path}"
      "uid=1000"
      "gid=100"

      "dir_mode=0775"
      "file_mode=0664"

      "_netdev"
      "x-systemd.automount"
      "noauto"

      "x-systemd.mount-timeout=30s"
    ];
  };
}
