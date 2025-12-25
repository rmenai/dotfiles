{ config, lib, ... }:
let
  cfg = config.features.hardware.tlp;
in
{
  options.features.hardware.tlp = {
    enable = lib.mkEnableOption "TLP power management";

    profile = lib.mkOption {
      type = lib.types.enum [
        "performance"
        "balanced"
      ];
      default = "performance";
      description = "Power management profile";
    };
  };

  config = lib.mkIf cfg.enable {
    services.thermald.enable = true;

    services.tlp = {
      enable = true;
      settings =
        if cfg.profile == "performance" then
          {
            CPU_SCALING_GOVERNOR_ON_AC = "performance";
            CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

            CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
            CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";

            PLATFORM_PROFILE_ON_AC = "performance";
            PLATFORM_PROFILE_ON_BAT = "balanced";

            RUNTIME_PM_ON_AC = "auto";
            RUNTIME_PM_ON_BAT = "auto";

            CPU_BOOST_ON_AC = 1;
            CPU_HWP_DYN_BOOST_ON_AC = 1;
            CPU_BOOST_ON_BAT = 0;
            CPU_HWP_DYN_BOOST_ON_BAT = 0;

            STOP_CHARGE_THRESH_BAT0 = 1;

            SOUND_POWER_SAVE_ON_AC = 0;
            SOUND_POWER_SAVE_ON_BAT = 0;
            SOUND_POWER_SAVE_CONTROLLER = "N";
            WIFI_PWR_ON_BAT = "off";
            WIFI_PWR_ON_AC = "off";
            RESTORE_DEVICE_STATE_ON_STARTUP = 1;
            USB_AUTOSUSPEND = 1;
          }
        else
          {
            CPU_SCALING_GOVERNOR_ON_AC = "balanced";
            CPU_ENERGY_PERF_POLICY_ON_AC = "balance_power";
            PLATFORM_PROFILE_ON_AC = "balance_power";
            RUNTIME_PM_ON_AC = "auto";
            WIFI_PWR_ON_AC = "on";

            CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
            CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
            PLATFORM_PROFILE_ON_BAT = "low-power";
            CPU_BOOST_ON_BAT = 0;
            CPU_HWP_DYN_BOOST_ON_BAT = 0;

            STOP_CHARGE_THRESH_BAT0 = 1;
          };
    };
  };
}
