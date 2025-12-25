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

      tlp = {
        enable = true;
        profile = "performance";
      };
    };

    services = {
      syncthing.enable = true;
      pipewire.enable = true;
      cups.enable = true;
    };

    desktop = {
      xserver.enable = true;
      sddm.enable = true;
      autoLogin.enable = true;
      fcitx.enable = true;

      hyprland.enable = true;
      catppuccin.enable = true;
      fonts.enable = true;
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

  services.syncthing.settings = {
    folders = {
      "Notes" = {
        id = "cgmyu-yuita";
        path = "/home/${config.spec.user}/Documents/Notes";
        devices = [
          "s23"
          "kernel"
        ];
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

  system.stateVersion = "25.11";
  boot.supportedFilesystems = [ "ntfs" ];

  security.sudo.extraConfig = ''
    Defaults !tty_tickets # share authentication across all ttys, not one per-tty
    Defaults lecture = never # rollback results in sudo lectures after each reboot
    Defaults timestamp_timeout=120 # only ask for password every 2h
  '';

  environment.sessionVariables = {
    WASTEBIN_URL = "https://bin.menai.me";
  };

  environment.systemPackages = with pkgs; [
    (writeShellScriptBin "colmena" ''
      cd /home/vault/.dotfiles/nixos
      exec ${colmena}/bin/colmena "$@" --impure
    '')

    # outputs.packages.${pkgs.stdenv.hostPlatform.system}.bin
    fastfetch
  ];

  programs = {
    nix-index-database.comma = {
      enable = true;
    };
  };

  sops.secrets = {
    "id_ed25519_vm" = {
      key = "users/vault/ssh_private_key";
      sopsFile = "${builtins.toString inputs.secrets}/hosts/vm.yaml";
      path = "/home/${config.spec.user}/.ssh/id_ed25519_vm";
      owner = config.spec.user;
      group = "users";
      mode = "0600";
    };

    "id_ed25519_vm.pub" = {
      key = "users/vault/ssh_public_key";
      sopsFile = "${builtins.toString inputs.secrets}/hosts/vm.yaml";
      path = "/home/${config.spec.user}/.ssh/id_ed25519_vm.pub";
      owner = config.spec.user;
      group = "users";
      mode = "0600";
    };

    "id_ed25519_kernel" = {
      key = "users/vault/ssh_private_key";
      sopsFile = "${builtins.toString inputs.secrets}/hosts/kernel.yaml";
      path = "/home/${config.spec.user}/.ssh/id_ed25519_kernel";
      owner = config.spec.user;
      group = "users";
      mode = "0600";
    };

    "id_ed25519_kernel.pub" = {
      key = "users/vault/ssh_public_key";
      sopsFile = "${builtins.toString inputs.secrets}/hosts/kernel.yaml";
      path = "/home/${config.spec.user}/.ssh/id_ed25519_kernel.pub";
      owner = config.spec.user;
      group = "users";
      mode = "0600";
    };
  };
}
