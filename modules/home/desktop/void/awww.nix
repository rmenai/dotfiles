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
    systemd.user.services.awww-wallpaper = {
      Unit = {
        Description = "Set awww wallpaper";
        Requires = [ "awww.service" ];
        After = [ "awww.service" ];
        PartOf = [ "awww.service" ];
      };

      Service = {
        Type = "oneshot";
        ExecStart = "${pkgs.awww}/bin/awww img ${./assets/wallpaper.png}";
        Restart = "on-failure";
        RestartSec = "1s";
      };

      Install = {
        WantedBy = [ "awww.service" ];
      };
    };
  };
}
