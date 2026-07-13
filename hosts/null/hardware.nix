{ lib, ... }:
{
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 16;
        editor = false;
      };

      efi.canTouchEfiVariables = true;
      timeout = lib.mkDefault 3;
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
