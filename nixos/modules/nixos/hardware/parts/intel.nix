{ config, lib, ... }:
{
  options.features.hardware.intel = {
    enable = lib.mkEnableOption "Intel CPU optimizations";
  };

  config = lib.mkIf config.features.hardware.intel.enable {
    hardware.cpu.intel.updateMicrocode = true;
    hardware.enableRedistributableFirmware = true;
  };
}
