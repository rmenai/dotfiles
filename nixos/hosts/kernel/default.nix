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
        syncthing.enable = true;
      };
    };

    apps = {
      core.enable = true;
      oxidise.enable = true;
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
}
