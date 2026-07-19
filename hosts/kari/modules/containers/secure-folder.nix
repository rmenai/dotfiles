{
  config,
  inputs,
  lib,
  outputs,
  pkgs,
  ...
}:
let
  # FR-200
  vpn = {
    ip = "149.102.245.129";
    port = "51820";
    pub = "m8vo9+NTxgkGJ1eV2nP9AyanXxeSlztAhIhQWDYPfnc=";
  };
in
{
  sops.secrets."secrets/proton_private_key" = {
    owner = "root";
    mode = "0400";
  };

  networking.nat = {
    enable = true;
    internalInterfaces = [ "ve-+" ];
    externalInterface = "wlp0s20f3";
  };

  containers.secure = {
    autoStart = false;
    privateNetwork = true; # Force separate network namespace
    hostAddress = "192.168.100.10";
    localAddress = "192.168.100.11";

    bindMounts = {
      "/home/void" = {
        hostPath = "/home/void";
        isReadOnly = false;
      };

      "/home/void/vpn.key" = {
        hostPath = config.sops.secrets."secrets/proton_private_key".path;
        isReadOnly = true;
      };

      "/tmp/wayland-1" = {
        hostPath = "/run/user/1000/wayland-1";
        isReadOnly = false;
      };

      "/dev/dri" = {
        hostPath = "/dev/dri";
        isReadOnly = false;
      };

      "/run/opengl-driver" = {
        hostPath = "/run/opengl-driver";
        isReadOnly = true;
      };
    };

    allowedDevices = [
      {
        node = "/dev/net/tun";
        modifier = "rw";
      }
    ];

    config = { config, pkgs, ... }: {
      imports = [
        inputs.home-manager.nixosModules.home-manager
        inputs.catppuccin.nixosModules.catppuccin
      ];

      time.timeZone = "Europe/Paris";
      system.stateVersion = "26.05";

      environment.variables = {
        NIXOS_OZONE_WL = "1";
        MOZ_ENABLE_WAYLAND = "1";
        QT_QPA_PLATFORM = "wayland;xcb";
        GDK_BACKEND = "wayland,x11";
      };

      users.users.void = {
        isNormalUser = true;
        uid = 1001;
        home = "/home/void";
        extraGroups = [
          "video"
          "audio"
        ];
      };

      home-manager = {
        useUserPackages = true;
        useGlobalPkgs = true;
        extraSpecialArgs = { inherit inputs outputs pkgs; };
        users.void = import ../../../../home/void/kari.nix;
      };

      environment.systemPackages = with pkgs; [
        wireguard-tools
        iptables
        curl
      ];

      networking = {
        useHostResolvConf = lib.mkForce false; # Prevent DNS leaks
        nameservers = [ "10.2.0.1" ];

        firewall.enable = false;

        wg-quick.interfaces = {
          wg0 = {
            address = [ "10.2.0.2/32" ];
            privateKeyFile = "/home/void/vpn.key";

            peers = [
              {
                publicKey = vpn.pub;
                allowedIPs = [ "0.0.0.0/0" ];
                endpoint = "${vpn.ip}:${vpn.port}";
              }
            ];

            postUp = ''
              # Block EVERYTHING entering or leaving the container
              ${pkgs.iptables}/bin/iptables -P OUTPUT DROP
              ${pkgs.iptables}/bin/iptables -P INPUT DROP
              ${pkgs.iptables}/bin/iptables -P FORWARD DROP

              # Allow internal loopback
              ${pkgs.iptables}/bin/iptables -A INPUT -i lo -j ACCEPT
              ${pkgs.iptables}/bin/iptables -A OUTPUT -o lo -j ACCEPT

              # Allow all traffic traveling THROUGH the encrypted tunnel
              ${pkgs.iptables}/bin/iptables -A INPUT -i wg0 -j ACCEPT
              ${pkgs.iptables}/bin/iptables -A OUTPUT -o wg0 -j ACCEPT

              # The ONLY unencrypted traffic allowed on the physical link (eth0)
              ${pkgs.iptables}/bin/iptables -A OUTPUT -o eth0 -d ${vpn.ip} -p udp --dport ${vpn.port} -j ACCEPT
              ${pkgs.iptables}/bin/iptables -A INPUT -i eth0 -s ${vpn.ip} -p udp --sport ${vpn.port} -j ACCEPT
            '';

            preDown = ''
              ${pkgs.iptables}/bin/iptables -P OUTPUT ACCEPT
              ${pkgs.iptables}/bin/iptables -P INPUT ACCEPT
              ${pkgs.iptables}/bin/iptables -P FORWARD ACCEPT
              ${pkgs.iptables}/bin/iptables -F
            '';
          };
        };
      };
    };
  };

  environment.systemPackages = with pkgs; [
    (writeShellScriptBin "secure-askpass" ''
      exec rofi -dmenu -password -p "Secure Folder Password:" -lines 0
    '')

    (writeShellScriptBin "secure-run" ''
      if [ "$EUID" -eq 0 ]; then
        echo "Error: Do not run this wrapper with sudo. Run it as your normal user."
        exit 1
      fi

      CMD=$(printf "%q " "$@")
      export SUDO_ASKPASS="/run/current-system/sw/bin/secure-askpass"

      sudo -k

      sudo -A ${pkgs.bash}/bin/bash -c "
        /run/current-system/sw/bin/nixos-container start secure 2>/dev/null
        /run/current-system/sw/bin/setfacl -m u:1001:rw /run/user/1000/wayland-1
        exec /run/current-system/sw/bin/nixos-container run secure -- su - void -c \"env WAYLAND_DISPLAY=/tmp/wayland-1 $CMD\"
      "
    '')
  ];

  security.sudo.extraConfig = ''
    # Block an attacker from manually running the container using an active terminal ticket
    Defaults!/run/current-system/sw/bin/nixos-container timestamp_timeout=0
  '';
}
