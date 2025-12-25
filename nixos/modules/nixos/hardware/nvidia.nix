{ config, lib, ... }:
let
  cfg = config.features.hardware.nvidia;
in
{
  options.features.hardware.nvidia = {
    enable = lib.mkEnableOption "NVIDIA GPU support";

    intelBusId = lib.mkOption {
      type = lib.types.str;
      example = "PCI:0:2:0";
      description = "Intel GPU PCI bus ID";
    };

    nvidiaBusId = lib.mkOption {
      type = lib.types.str;
      example = "PCI:1:0:0";
      description = "NVIDIA GPU PCI bus ID";
    };
  };

  config = lib.mkIf cfg.enable {
    hardware = {
      enableAllFirmware = true;
      graphics.enable = true;

      nvidia = {
        package = config.boot.kernelPackages.nvidiaPackages.latest;
        modesetting.enable = true;
        nvidiaSettings = true;
        open = true;

        # These cause options with performence and suspend
        powerManagement.enable = false;
        powerManagement.finegrained = false;

        # Info: <https://wiki.nixos.org/wiki/NVIDIA#Common_setup>
        prime = {
          inherit (cfg) intelBusId;
          inherit (cfg) nvidiaBusId;

          offload = {
            enable = true;
            enableOffloadCmd = true;
          };
        };
      };
    };
  };
}
