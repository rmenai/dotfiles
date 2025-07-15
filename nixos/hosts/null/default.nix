{ config, func, inputs, lib, pkgs, ... }: {
  imports = lib.flatten [
    (map func.custom.relativeToRoot [ "modules/common" ])
    (map func.custom.relativeToRoot [ "modules/nixos" ])

    ./hardware.nix
    ./networking.nix
    ./vm.nix
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

    hardware = {
      disko = {
        profile = "btrfs-luks";
        device = "/dev/nvme0n1";
        swapSize = "32G";
      };

      nvidia = {
        enable = true;
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };

      intel.enable = true;
      ssd.enable = true;
      ram.enable = true;
    };

    boot = {
      systemd.enable = true;
      initrd.enable = true;
    };

    services = {
      audio = { pipewire.enable = true; };
      printing = { cups.enable = true; };
      security = { tpm.enable = true; };

      networking = {
        networkManager.enable = true;
        bluetooth.enable = true;
        openssh.enable = true;
        tailscale.enable = true;
      };

      power = {
        tlp = {
          enable = true;
          profile = "performance";
        };
      };

      virtualization = {
        libvirt.enable = true;
        virtualbox.enable = true;
        waydroid.enable = true;
        podman.enable = true;
      };
    };

    impermanence = {
      enable = true;
      persistFolder = "/persist";
    };

    hibernation = {
      enable = true;
      resumeDevice = "/dev/disk/by-uuid/dfe71357-a2e8-479a-b976-0cd1269cbfa2";
      resumeOffset = "533760";
      delaySec = "1h";
    };

    display = {
      xserver.enable = true;
      sddm.enable = true;
      autoLogin.enable = true;
    };

    desktop = {
      hyprland.enable = true;
      fonts.enable = true;
    };

    apps = {
      core.enable = true;
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

  sops.secrets."id_ed25519_ubuntu" = {
    key = "users/vault/ssh_private_key";
    sopsFile = "${builtins.toString inputs.secrets}/hosts/ubuntu.yaml";
    path = "/home/${config.spec.user}/.ssh/id_ed25519_ubuntu";
    owner = config.spec.user;
    group = "users";
    mode = "0600";
  };

  sops.secrets."id_ed25519_ubuntu.pub" = {
    key = "users/vault/ssh_public_key";
    sopsFile = "${builtins.toString inputs.secrets}/hosts/ubuntu.yaml";
    path = "/home/${config.spec.user}/.ssh/id_ed25519_ubuntu.pub";
    owner = config.spec.user;
    group = "users";
    mode = "0600";
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [ stdenv libgcc libllvm portaudio ];
  };

  environment.systemPackages = [ pkgs.colmena ];
}
