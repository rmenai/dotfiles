{ config, lib, ... }: {
  networking = {
    useNetworkd = true;
    usePredictableInterfaceNames = false;
    dhcpcd.enable = false;

    firewall = {
      enable = true;

      trustedInterfaces = [ "tailscale0" "podman0" ];
      allowedTCPPorts = lib.mkForce [ 80 443 ];
      allowedUDPPorts = lib.mkForce [ 41641 ];
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

    globalConfig = ''
      servers {
        trusted_proxies cloudflare {
          interval 12h
          timeout 15s
        }
      }
    '';

    extraConfig = ''
      # Global snippet for Cloudflare DNS
      (cloudflare) {
        tls {
          dns cloudflare {env.CLOUDFLARE_API_KEY}
        }
      }

      # Global snippet for logging
      (logging) {
        log {
          output file /var/log/caddy/access.log {
            roll_size 100mb
            roll_keep 5
            roll_keep_for 168h
          }
        }
      }

      # Global snippet for security headers
      (security) {
        header {
          # Security headers
          Strict-Transport-Security "max-age=31536000; includeSubDomains; preload"
          X-Content-Type-Options "nosniff"
          X-Frame-Options "DENY"
          X-XSS-Protection "1; mode=block"
          Referrer-Policy "strict-origin-when-cross-origin"

          # Remove server info
          -Server
        }
      }

      (common) {
        import cloudflare
        import logging
        import security
      }

      lab.menai.me {
        rate_limit {
          zone shared {
            key {client_ip}
            events 100
            window 1m
          }
        }

        redir / /status/home 301
        reverse_proxy http://127.0.0.1:3001
        import common
      }

      go.menai.me {
        rate_limit {
          zone shared {
            key {client_ip}
            events 100
            window 1m
          }
        }

        redir / https://shlink.lab.menai.me permanent
        reverse_proxy http://127.0.0.1:8385
        import common
      }

      bin.menai.me {
        rate_limit {
          zone shared {
            key {client_ip}
            events 100
            window 1m
          }
          zone uploads {
            match {
              method POST
            }
            key {client_ip}
            events 64
            window 10m
          }
        }

        request_body {
          max_size 100KB
        }

        reverse_proxy http://127.0.0.1:8088
        import common
      }

      bytes.menai.me {
        rate_limit {
          zone shared {
            key {client_ip}
            events 100
            window 1m
          }
          zone uploads {
            match {
              method POST
            }
            key {client_ip}
            events 64
            window 10m
          }
        }

        request_body {
          max_size 100KB
        }

        reverse_proxy http://127.0.0.1:5000
        import common
      }

      vault.menai.me {
        rate_limit {
          zone shared {
            key {client_ip}
            events 200
            window 1m
          }
        }

        redir /admin* https://vault.lab.menai.me{uri} permanent
        reverse_proxy http://127.0.0.1:8222
        import common
      }

      search.menai.me {
        reverse_proxy http://127.0.0.1:9080
        import common
      }

      tools.menai.me {
        redir /* https://omni.tools.menai.me{uri} permanent
        import common
      }

      omni.tools.menai.me {
        reverse_proxy http://127.0.0.1:8080
        import common
      }

      pdf.tools.menai.me {
        reverse_proxy http://127.0.0.1:8082
        import common
      }

      chef.tools.menai.me {
        reverse_proxy http://127.0.0.1:8083
        import common
      }

      vault.lab.menai.me {
        redir / /admin 301
        reverse_proxy http://127.0.0.1:8222
        import common
      }

      uptime.lab.menai.me {
        reverse_proxy http://127.0.0.1:3001
        import common
      }

      shlink.lab.menai.me {
        reverse_proxy http://127.0.0.1:8386
        import common
      }

      syncthing.lab.menai.me {
        reverse_proxy http://127.0.0.1:8384
        import common
      }

      adguard.lab.menai.me {
        reverse_proxy http://127.0.0.1:3000
        import common
      }
    '';
  };

  services.fail2ban = {
    jails = {
      # General HTTP flood protection
      http-flood = {
        settings = {
          enabled = true;
          filter = "http-flood";
          action = "iptables[name=HTTP-FLOOD, port=http, protocol=tcp]";
          logpath = "/var/log/caddy/access.log";
          maxretry = 100; # 100 requests
          bantime = "10m";
          findtime = "1m"; # Within 1 minute
        };
      };
    };

    ignoreIP = [
      # Add Cloudflare IP ranges to avoid blocking legitimate traffic
      "103.21.244.0/22"
      "103.22.200.0/22"
      "103.31.4.0/22"
      "104.16.0.0/13"
      "104.24.0.0/14"
      "108.162.192.0/18"
      "131.0.72.0/22"
      "141.101.64.0/18"
      "162.158.0.0/15"
      "172.64.0.0/13"
      "173.245.48.0/20"
      "188.114.96.0/20"
      "190.93.240.0/20"
      "197.234.240.0/22"
      "198.41.128.0/17"
    ];
  };

  environment.etc = {
    "fail2ban/filter.d/http-flood.conf".text = ''
      [Definition]
      # General flood protection for all services
      failregex = ^<HOST> - - \[.*\] ".* HTTP/.*" .* .*$
      ignoreregex =
    '';
  };
}
