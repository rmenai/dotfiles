{ config, lib, ... }:
{
  options.features.hardware.ssd = {
    enable = lib.mkEnableOption "SSD optimizations";
  };

  config = lib.mkIf config.features.hardware.ssd.enable {
    boot.supportedFilesystems = [
      "ntfs"
      "btrfs"
    ];
    services.fstrim.enable = true;
  };
}
