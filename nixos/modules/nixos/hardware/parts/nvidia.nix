{ config, lib, ... }:
{
  options.features.hardware.nvidia = {
    enable = lib.mkEnableOption "NVIDIA GPU support";

    intelBusId = lib.mkOption {
      type = lib.types.str;
      default = "PCI:0:2:0";
      description = "Intel GPU PCI bus ID";
    };

    nvidiaBusId = lib.mkOption {
      type = lib.types.str;
      default = "PCI:1:0:0";
      description = "NVIDIA GPU PCI bus ID";
    };
  };

  config = lib.mkIf config.features.hardware.nvidia.enable {
    hardware.enableAllFirmware = true;
    hardware.graphics = {
      enable = true;
    };

    hardware.nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.latest;
      modesetting.enable = true;
      nvidiaSettings = true;
      open = true;

      # These cause options with performence and suspend
      powerManagement.enable = false;
      powerManagement.finegrained = false;

      # Info: <https://wiki.nixos.org/wiki/NVIDIA#Common_setup>
      prime = {
        intelBusId = config.features.hardware.nvidia.intelBusId;
        nvidiaBusId = config.features.hardware.nvidia.nvidiaBusId;

        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
      };
    };
  };
}
