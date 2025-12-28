{ config, lib, ... }:
let
  cfg = config.features.services.adjust-power;
in
{
  options.features.services.adjust-power = {
    enable = lib.mkEnableOption "Hyprland power adjustment service";
  };

  config = lib.mkIf cfg.enable {
    systemd.user.services.hyprland-adjust-power = {
      Unit = {
        Description = "Change profile based on power";
        After = [ "hyprland.service" ];
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
      Service = {
        ExecStart = "/home/${config.spec.user}/.config/hypr/scripts/adjust-power.sh";
        Type = "simple";
        Restart = "always";
        RestartSec = "1s";
      };
    };
  };
}
