{ modulesPath, ... }:
{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot = {
    kernelModules = [ "kvm-intel" ];
    initrd.kernelModules = [ "dm-snapshot" ];
    initrd.availableKernelModules = [
      "xhci_pci"
      "thunderbolt"
      "nvme"
      "usb_storage"
      "sd_mod"
      "rtsx_pci_sdmmc"
    ];
  };

  nixpkgs.hostPlatform = "x86_64-linux";

  features = {
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

      lazaboote = {
        enable = true;
        pkiBundle = "/var/lib/sbctl";
        configurationLimit = 16;
      };

      hibernation = {
        enable = true;
        resumeDevice = "/dev/disk/by-uuid/dfe71357-a2e8-479a-b976-0cd1269cbfa2";
        resumeOffset = "533760";
        delaySec = "1h";
      };

      tpm.enable = true;
    };
  };

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 16;
        editor = false;
      };

      efi.canTouchEfiVariables = true;
      timeout = 3;
    };

    initrd.systemd.enable = true;
  };

  hardware.enableRedistributableFirmware = true;
  hardware.cpu.intel.updateMicrocode = true;
  services.fstrim.enable = true;
  services.btrfs.autoScrub.enable = true;

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 30;
    # priority = 100;
  };
}
