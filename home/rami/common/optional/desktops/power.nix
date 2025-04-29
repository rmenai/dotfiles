{
  pkgs,
  config,
  ...
}: {
  systemd.user.services.hyprland-adjust-power = {
    Unit = {
      Description = "Change profile based on power";
      After = ["hyprland.service"];
    };
    Install = {
      WantedBy = ["default.target"];
    };
    Service = {
      ExecStart = "${pkgs.bash}/bin/bash ${config.hostSpec.home}/.config/hypr/scripts/adjust-power.sh";
      Type = "simple";
      Restart = "always";
      RestartSec = "1s";
    };
  };
}
