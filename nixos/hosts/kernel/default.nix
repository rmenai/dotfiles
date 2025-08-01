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
        vaultwarden.enable = true;
        wastebin.enable = true;
        bytestash.enable = true;
        shlink.enable = true;
        omnitools.enable = true;
        stirlingpdf.enable = true;
        cyberchef.enable = true;
        searxng.enable = true;
        tandoor.enable = true;
      };

      security.fail2ban.enable = true;
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
      WASTEBIN_MAX_BODY_SIZE = 100 * 1024; # 100KB
      WASTEBIN_THEME = "catppuccin";
      WASTEBIN_TITLE = "wastebin";
      WASTEBIN_PASTE_EXPIRATIONS = "10m,1h,1d,1w=d,1M,1y,0";
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

  services.nullmailer = {
    config = {
      me = "menai.me";
      defaulthost = "menai.me";
      defaultdomain = "menai.me";
      allmailfrom = "noreply@mail.menai.me";
      adminaddr = "rami@menai.me";
    };
  };

  services.vaultwarden = {
    config = {
      DOMAIN = "https://vault.menai.me";
      SIGNUPS_ALLOWED = false;

      SMTP_HOST = "smtp.eu.mailgun.org";
      SMTP_FROM = "noreply@mail.menai.me";
      SMTP_USERNAME = "noreply@mail.menai.me";
      SMTP_PORT = 2525;
    };
  };

  services.tandoor-recipes = {
    extraConfig = {
      DOMAIN = "https://vault.menai.me";
      ALLOWED_HOSTS = "recipes.menai.me,chef.menai.me,chef.lab.menai.me";
      ENABLE_PDF_EXPORT = 1;
      ENABLE_SIGNUP = 0;
      EMAIL_HOST = "smtp.eu.mailgun.org";
      EMAIL_PORT = 2525;
      EMAIL_HOST_USER = "noreply@mail.menai.me";
      DEFAULT_FROM_EMAIL = "noreply@mail.menai.me";
      EMAIL_USE_TLS = 1;
      EMAIL_USE_SSL = 0;
    };
  };

  environment.sessionVariables.WASTEBIN_URL = "https://bin.menai.me";

  # TODO
  # - Nextcloud
  # - Immich
  # - KeyCloack
  # - Restic

  # - Calibre-Web
  # - AudioBookshelf
  # - iSponsorBlockTV
  # - Komga

  # - Paperless

  # - Picsur
  # - tubetube
}
