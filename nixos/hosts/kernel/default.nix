{ config, func, lib, ... }: {
  imports = lib.flatten [
    (map func.custom.relativeToRoot [ "modules/common" ])
    (map func.custom.relativeToRoot [ "modules/nixos" ])

    ./hardware.nix
    ./networking.nix
    ./variants.nix
  ];

  spec = {
    host = "kernel";
    timeZone = "Europe/Paris";
    defaultLocale = "en_US.UTF-8";
  };

  deployment = {
    targetHost = "kernel";
    targetUser = "root";
    tags = [ "vps" ];
  };

  features = {
    profiles = { core.enable = true; };
    users = { vault.enable = true; };

    system = {
      nix.enable = true;
      home.enable = true;
      sops.enable = true;
    };

    services = {
      networking = {
        openssh.enable = true;
        tailscale.enable = true;
        caddy.enable = true;
        syncthing.enable = true;
        adguardhome.enable = true;
        hastebin.enable = true;
        shlink.enable = true;
      };

      databases.postgresql.enable = true;
      monitoring.uptime-kuma.enable = true;
      virtualization.podman.enable = true;
    };

    apps = {
      core.enable = true;
      oxidise.enable = true;
    };
  };

  virtualisation.oci-containers.containers."shlink" = {
    environment = {
      DEFAULT_DOMAIN = "go.menai.me";
      IS_HTTPS_ENABLED = "true";
      SHORT_URL_TRAILING_SLASH = "true";
      GEOLITE_LICENSE_KEY = config.private.secrets.geoliteKey;
      ANONYMIZE_REMOTE_ADDR = "false";
    };
  };

  virtualisation.oci-containers.containers."shlink-web" = {
    environment = {
      SHLINK_SERVER_NAME = "menai.me";
      SHLINK_SERVER_URL = "https://go.menai.me";
      SHLINK_SERVER_API_KEY = config.private.secrets.shlinkKey;
    };
  };

  services.wastebin = {
    settings = {
      WASTEBIN_BASE_URL = "https://bin.menai.me";
      WASTEBIN_MAX_BODY_SIZE = "1048576"; # 1MB
      WASTEBIN_THEME = "catppuccin";
      WASTEBIN_TITLE = "wastebin";
    };
  };

  services.adguardhome = {
    settings = {
      dns = {
        upstream_dns = [
          "https://dns.quad9.net/dns-query"
          "https://1.1.1.1/dns-query"
          "https://1.0.0.1/dns-query"
        ];
        fallback_dns = [ "1.1.1.1" "1.0.0.1" ];
      };

      filtering = {
        protection_enabled = true;
        filtering_enabled = true;
      };
    };
  };

  services.syncthing.settings = {
    folders = {
      "Notes" = {
        id = "cgmyu-yuita";
        path = "/home/${config.spec.user}/Documents/Notes";
        devices = [ "s23" "null" ];
        ignorePerms = true;
        versioning = {
          type = "staggered";
          fsPath = ".stversions";
          params = {
            cleanInterval = "86400";
            maxAge = "31536000";
          };
        };
      };
    };
  };

  # TODO
  # - Nextcloud
  # - Immich
  # - Calibre-Web
  # - Audiobookshelf
  # - SearxNG
  # - KeyCloack
  # - Restic
  # - Microbin
}
