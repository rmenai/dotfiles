{ func, inputs, lib, pkgs, ... }: {
  imports = lib.flatten [
    inputs.disko.nixosModules.disko
    inputs.impermanence.nixosModules.impermanence
    inputs.lanzaboote.nixosModules.lanzaboote
    inputs.home-manager.nixosModules.home-manager
    inputs.sops-nix.nixosModules.sops

    (map func.custom.relativeToRoot [ "modules/common" ])
    (map func.custom.relativeToRoot [ "modules/nixos" ])

    ./hardware.nix
    ./vm.nix
  ];

  spec = {
    hostName = "null";
    timeZone = "Europe/Paris";
    defaultLocale = "en_US.UTF-8";
  };

  features = {
    profiles = { core.enable = true; };
    users = { vault.enable = true; };

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

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [ stdenv libgcc libllvm portaudio ];
  };

  systemd.network.networks."10-wlp0s20f3" = {
    matchConfig.Name = "wlp0s20f3";
    networkConfig.DHCP = "yes";
  };

  networking.extraHosts = ''
    10.10.10.10 kali
    10.10.10.8  flare
  '';
}
