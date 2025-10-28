{ config, func, inputs, lib, pkgs, ... }: {
  imports = lib.flatten [
    inputs.nix-index-database.nixosModules.nix-index
    inputs.microvm.nixosModules.host

    (map func.custom.relativeToRoot [ "modules/common" ])
    (map func.custom.relativeToRoot [ "modules/nixos" ])

    ./hardware.nix
    ./networking.nix
    ./variants.nix
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
    profiles = { core.enable = true; };
    users = { vault.enable = true; };

    system = {
      nix.enable = true;
      home.enable = true;
      sops.enable = true;
    };

    services = {
      audio = {
        pipewire.enable = true;
        mpd.enable = true;
      };

      printing = { cups.enable = true; };

      power.tlp = {
        enable = true;
        profile = "performance";
      };

      networking = {
        bluetooth.enable = true;
        tailscale.enable = true;
        openssh.enable = true;
        syncthing.enable = true;
      };

      security = {
        tpm.enable = true;
        fail2ban.enable = true;
      };

      virtualization = {
        libvirt.enable = true;
        virtualbox.enable = true;
        waydroid.enable = true;
        microvm.enable = true;
        podman.enable = true;
      };
    };

    display = {
      xserver.enable = true;
      sddm.enable = true;
      autoLogin.enable = true;
    };

    desktop = {
      hyprland.enable = true;
      catppuccin.enable = true;
      fonts.enable = true;
    };

    apps = {
      core.enable = true;
      index.enable = true;
      oxidise.enable = true;
      gaming.enable = true;
      obs.enable = true;
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
        devices = [ "s23" "kernel" ];
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

  sops.secrets."id_ed25519_vm" = {
    key = "users/vault/ssh_private_key";
    sopsFile = "${builtins.toString inputs.secrets}/hosts/vm.yaml";
    path = "/home/${config.spec.user}/.ssh/id_ed25519_vm";
    owner = config.spec.user;
    group = "users";
    mode = "0600";
  };

  sops.secrets."id_ed25519_vm.pub" = {
    key = "users/vault/ssh_public_key";
    sopsFile = "${builtins.toString inputs.secrets}/hosts/vm.yaml";
    path = "/home/${config.spec.user}/.ssh/id_ed25519_vm.pub";
    owner = config.spec.user;
    group = "users";
    mode = "0600";
  };

  sops.secrets."id_ed25519_kernel" = {
    key = "users/vault/ssh_private_key";
    sopsFile = "${builtins.toString inputs.secrets}/hosts/kernel.yaml";
    path = "/home/${config.spec.user}/.ssh/id_ed25519_kernel";
    owner = config.spec.user;
    group = "users";
    mode = "0600";
  };

  sops.secrets."id_ed25519_kernel.pub" = {
    key = "users/vault/ssh_public_key";
    sopsFile = "${builtins.toString inputs.secrets}/hosts/kernel.yaml";
    path = "/home/${config.spec.user}/.ssh/id_ed25519_kernel.pub";
    owner = config.spec.user;
    group = "users";
    mode = "0600";
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [ stdenv libgcc libllvm portaudio ];
  };

  environment.systemPackages = with pkgs;
    [
      (writeShellScriptBin "colmena" ''
        cd /home/vault/.dotfiles/nixos
        exec ${colmena}/bin/colmena "$@" --impure
      '')
    ];

  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "ja_JP.UTF-8/UTF-8"
    "fr_FR.UTF-8/UTF-8"
    "ar_EG.UTF-8/UTF-8"
  ];

  # Japanese keyboard
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      addons = with pkgs; [
        fcitx5-mozc
        fcitx5-configtool # A GUI to configure Fcitx5
        fcitx5-gtk # For GTK (Gnome, XFCE) apps
      ];
    };
  };

  services.xserver.xkb = {
    layout = "us, fr, ara";
    options = "grp:alt_shift_toggle";
  };

  environment.sessionVariables.WASTEBIN_URL = "https://bin.menai.me";
}
