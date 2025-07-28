{ config, lib, ... }: {
  networking = {
    useNetworkd = true;
    usePredictableInterfaceNames = false;
    dhcpcd.enable = false;

    firewall = {
      trustedInterfaces = [ "tailscale0" ];

      allowedTCPPorts = lib.mkForce [ 80 53 443 853 ];
      allowedUDPPorts = lib.mkForce [ 53 41641 ];
    };
  };

  systemd.services.systemd-resolved.enable = false;

  systemd.network = {
    enable = true;

    networks."10-eth0" = {
      matchConfig.Name = "eth0";
      address = [ "165.232.86.69/20" "10.18.0.5/16" ];
      routes = [{ Gateway = "165.232.80.1"; }];
      dns = [ "127.0.0.1" "8.8.8.8" ];
    };

    networks."20-eth1" = {
      matchConfig.Name = "eth1";
      address = [ "10.110.0.4/20" ];
    };
  };

  services.udev.extraRules = ''
    ATTR{address}=="0e:32:f5:58:1e:df", NAME="eth0"
    ATTR{address}=="5a:01:5c:11:9c:4e", NAME="eth1"
  '';

  sops.secrets."secrets/cloudflare" = { };

  services.caddy = {
    environmentFile = config.sops.secrets."secrets/cloudflare".path;

    extraConfig = ''
      # Global snippet for Cloudflare DNS
      (cloudflare) {
      	tls {
      		dns cloudflare {env.CLOUDFLARE_API_KEY}
      	}
      }

      lab.menai.me {
      	redir / /status/home 301
      	reverse_proxy http://127.0.0.1:3001
      	import cloudflare
      }

      syncthing.lab.menai.me {
      	reverse_proxy http://127.0.0.1:8384
      	import cloudflare
      }

      adguard.lab.menai.me {
      	reverse_proxy http://127.0.0.1:3000
      	import cloudflare
      }
    '';
  };
}
