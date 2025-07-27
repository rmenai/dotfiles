{ config, lib, ... }: {
  # Enable IP forwarding
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
  };

  networking = {
    useNetworkd = true;
    usePredictableInterfaceNames = false;
    dhcpcd.enable = false;

    firewall = {
      trustedInterfaces = [ "tailscale0" ];

      allowedTCPPorts = lib.mkForce [ 80 53 443 853 ];
      allowedUDPPorts = lib.mkForce [ 41641 ];
    };
  };

  systemd.services.systemd-resolved.enable = false;

  systemd.network = {
    enable = true;

    networks."10-eth0" = {
      matchConfig.Name = "eth0";
      address = [ "167.99.219.56/20" "10.18.0.6/16" ];
      routes = [{ Gateway = "167.99.208.1"; }];
      dns = [ "8.8.8.8" ];
    };

    networks."20-eth1" = {
      matchConfig.Name = "eth1";
      address = [ "10.110.0.4/20" ];
    };
  };

  services.udev.extraRules = ''
    ATTR{address}=="ce:93:e8:f9:b7:a2", NAME="eth0"
    ATTR{address}=="96:3f:75:64:a3:0d", NAME="eth1"
  '';

  sops.secrets."secrets/cloudflare" = { };

  # Enable ACME for Let's Encrypt
  security.acme = {
    acceptTerms = true;
    defaults = {
      email = "rami@menai.me";
      dnsProvider = "cloudflare";
      dnsResolver = "1.1.1.1:53";
      environmentFile = config.sops.secrets."secrets/cloudflare".path;
      webroot = null;
    };
  };

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
      	reverse_proxy http://localhost:3001
      	import cloudflare
      }

      syncthing.lab.menai.me {
      	reverse_proxy http://kernel:8384
      	import cloudflare
      }

      adguard.lab.menai.me {
      	reverse_proxy http://kernel:3000
      	import cloudflare
      }
    '';
  };
}
