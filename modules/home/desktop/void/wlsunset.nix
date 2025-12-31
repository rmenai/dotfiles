{ config, lib, ... }:
let
  cfg = config.features.desktop.void;
in
{
  config = lib.mkIf cfg.enable {
    services.wlsunset = {
      enable = true;
      systemdTarget = "graphical-session.target";

      # France, Lyon
      longitude = "45.7";
      latitude = "4.9";

      temperature.day = 6500;
      temperature.night = 4000;
    };
  };
}
