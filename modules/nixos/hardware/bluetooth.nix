{
  config,
  lib,
  ...
}:
let
  cfg = config.features.hardware.bluetooth;
  persistFolder = config.spec.persistFolder;
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

    environment.persistence.${persistFolder}.directories = [
      "/var/lib/bluetooth"
    ];
  };
}
