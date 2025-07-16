{ config, lib, ... }: {
  options.features.services.networking.bluetooth = {
    enable = lib.mkEnableOption "Bluetooth configuration";

    powerOnBoot = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to power on Bluetooth on boot";
    };
  };

  config = lib.mkIf config.features.services.networking.bluetooth.enable {
    services.blueman.enable = true;

    hardware.bluetooth = {
      enable = true;
      powerOnBoot = config.features.services.networking.bluetooth.powerOnBoot;

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
    features.persist = { directories = { "/var/lib/bluetooth" = true; }; };
  };
}
