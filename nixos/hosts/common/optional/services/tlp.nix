{
  services.thermald.enable = true;

  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "low-power";

      CPU_BOOST_ON_BAT = 0;
      CPU_HWP_DYN_BOOST_ON_BAT = 0;

      STOP_CHARGE_THRESH_BAT0 = 1;
    };
  };
}
# {
#   services.thermald.enable = true;
#
#   services.tlp = {
#     enable = true;
#     settings = {
#       CPU_SCALING_GOVERNOR_ON_AC = "balanced";
#       CPU_ENERGY_PERF_POLICY_ON_AC = "balance_power";
#       PLATFORM_PROFILE_ON_AC = "balance_power";
#       RUNTIME_PM_ON_AC = "auto";
#       WIFI_PWR_ON_AC = "on";
#
#       CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
#       CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
#       PLATFORM_PROFILE_ON_BAT = "low-power";
#       CPU_BOOST_ON_BAT = 0;
#       CPU_HWP_DYN_BOOST_ON_BAT = 0;
#
#       STOP_CHARGE_THRESH_BAT0 = 1;
#     };
#   };
# }
#

