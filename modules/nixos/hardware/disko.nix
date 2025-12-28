{ lib, ... }:
{
  options.features.hardware.disko = {
    profile = lib.mkOption {
      type = lib.types.nullOr (
        lib.types.enum [
          "btrfs-luks"
          "btrfs-lvm"
          "simple-ext4"
        ]
      );
      default = null;
      description = "Disk layout profile to use";
    };

    device = lib.mkOption {
      type = lib.types.str;
      example = "/dev/nvme0n1";
      description = "Primary disk device";
    };

    swapSize = lib.mkOption {
      type = lib.types.str;
      example = "32G";
      description = "Swap file size";
    };
  };
}
