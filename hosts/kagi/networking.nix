{
  config,
  lib,
  pkgs,
  ...
}:
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

      allowedTCPPorts = lib.mkForce [ ];
      allowedUDPPorts = lib.mkForce [ ];

      extraCommands = ''
        # Netavark firewall rules
        # HTTP (80) and HTTPS (443)

        # Allow loopback traffic
        iptables -A INPUT -i lo -j ACCEPT
        ip6tables -A INPUT -i lo -j ACCEPT

        # Allow established and related outgoing traffic to return safely
        iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
        ip6tables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

        # Tailscale (41641)
        iptables -A INPUT -p udp --dport 41641 -j ACCEPT
        ip6tables -A INPUT -p udp --dport 41641 -j ACCEPT

        # Allow Tailscale interface completely
        iptables -A INPUT -i tailscale0 -j ACCEPT
        ip6tables -A INPUT -i tailscale0 -j ACCEPT

        # Allow Podman networks (10.89.x.x) to access wgexporter on the host
        iptables -A INPUT -s 10.89.0.0/16 -p tcp --dport 9586 -j ACCEPT
      '';

      extraStopCommands = ''
        iptables -F INPUT || true
        ip6tables -F INPUT || true
      '';
    };
  };

  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "fs.inotify.max_user_watches" = 524288;
    "fs.inotify.max_user_instances" = 8192;
  };

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

      "noatime"
      "_netdev"
      "x-systemd.automount"
      "noauto"

      "x-systemd.mount-timeout=30s"
    ];
  };
}
