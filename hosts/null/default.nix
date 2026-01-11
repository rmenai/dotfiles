{
  config,
  func,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = lib.flatten [
    (map func.custom.relativeToRoot [ "modules/common" ])
    (map func.custom.relativeToRoot [ "modules/nixos" ])

    ./hardware.nix
    ./networking.nix
    ./scratch.nix

    ./variants
  ];

  spec = {
    host = "null";
    timeZone = "Europe/Paris";
    defaultLocale = "en_US.UTF-8";
    persistFolder = "/persist";
  };

  deployment = {
    allowLocalDeployment = true;
    targetHost = "null";
    targetUser = "root";
    tags = [ "laptop" ];
  };

  features = {
    profiles = {
      core.enable = true;
      gaming.enable = true;
      virt.enable = true;
    };

    core = {
      persistence.enable = true;
      nix-ld.enable = true;
      cache.enable = true;
      diff.enable = true;
    };

    users = {
      vault.enable = true;
    };

    hardware = {
      bluetooth.enable = true;

      # tlp = {
      #   enable = true;
      #   profile = "performance";
      # };
    };

    services = {
      syncthing.enable = true;
      pipewire.enable = true;
      cups.enable = true;
    };

    desktop = {
      sddm.enable = true;
      niri.enable = true;
      fcitx.enable = true;
      fonts.enable = true;
      catppuccin.enable = true;
    };

    apps = {
      obs.enable = false;
      adb.enable = true;
    };

    containers = {
      httpd.enable = false;
      echo.enable = false;
    };
  };

  system.stateVersion = "25.11";
  boot.supportedFilesystems = [ "ntfs" ];

  security.sudo.extraConfig = ''
    Defaults !tty_tickets # share authentication across all ttys, not one per-tty
    Defaults lecture = never # rollback results in sudo lectures after each reboot
    Defaults timestamp_timeout=120 # only ask for password every 2h
  '';

  services.displayManager.autoLogin = {
    enable = false;
    user = config.spec.user;
  };

  services.syncthing.settings = {
    folders = {
      "Notes" = {
        id = "cgmyu-yuita";
        path = "/home/${config.spec.user}/Documents/Notes";
        devices = [ "s23" ];
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

  environment.systemPackages = with pkgs; [
    inputs.colmena.packages.${pkgs.system}.colmena
    fastfetch
  ];

  programs = {
    nix-index-database.comma.enable = true;
  };
}
