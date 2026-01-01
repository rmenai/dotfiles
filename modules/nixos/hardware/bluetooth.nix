{
  config,
  lib,
  ...
}:
let
  cfg = config.features.hardware.bluetooth;
in
{
  options.features.hardware.bluetooth = {
    enable = lib.mkEnableOption "Bluetooth configuration";

    powerOnBoot = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to power on Bluetooth on boot";
    };
  };

  config = lib.mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = cfg.powerOnBoot;

      settings = {
        General = {
          Experimental = true;
          Privacy = "device";
          JustWorksRepairing = "always";
          Class = "0x000100";
        };

        Policy = {
          ControllerMode = "dual";
          AutoEnable = true;
        };
      };
    };

    features.core.persistence = {
      directories = [
        "/var/lib/bluetooth"
      ];
    };
  };
}
