{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.desktop.void;
in
{
  config = lib.mkIf cfg.enable {
    systemd.user.services.swww-wallpaper = {
      Unit = {
        Description = "Set swww wallpaper";
        Requires = [ "swww.service" ];
        After = [ "swww.service" ];
        PartOf = [ "swww.service" ];
      };

      Service = {
        Type = "oneshot";
        ExecStart = "${pkgs.swww}/bin/swww img %h/Pictures/Wallpapers/wallpaper.png";
        Restart = "on-failure";
        RestartSec = "1s";
      };

      Install = {
        WantedBy = [ "swww.service" ];
      };
    };
  };
}
