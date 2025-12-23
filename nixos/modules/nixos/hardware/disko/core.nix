{ lib, ... }:
{
  options.features.hardware.disko = {
    profile = lib.mkOption {
      type = lib.types.enum [
        "none"
        "btrfs-luks"
        "btrfs-lvm"
        "simple-ext4"
      ];
      default = "none";
      description = "Disk layout profile to use";
    };

    device = lib.mkOption {
      type = lib.types.str;
      default = "/dev/nvme0n1";
      description = "Primary disk device";
    };

    swapSize = lib.mkOption {
      type = lib.types.str;
      default = "32G";
      description = "Swap file size";
    };
  };
}
