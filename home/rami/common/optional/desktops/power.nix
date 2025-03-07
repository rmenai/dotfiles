{pkgs, ...}: {
  systemd.user.services.hyprland-adjust-power = {
    Unit = {
      Description = "Change profile based on power";
      After = ["hyprland.service"];
    };
    Install = {
      WantedBy = ["default.target"];
    };
    Service = {
      ExecStart = "${pkgs.writeShellScript "hyprland-adjust-power.sh" ''
        if [ -f /sys/class/power_supply/BAT0/status ]; then
          battery_status=$(cat /sys/class/power_supply/BAT0/status)

          if [ "$battery_status" = "Discharging" ]; then
            ${pkgs.hyprland}/bin/hyprctl keyword monitor 'eDP-1, 1920x1200@60, 0x0, 1'
          else
            ${pkgs.hyprland}/bin/hyprctl keyword monitor 'eDP-1, highres@highrr, 0x0, 1.6'
          fi
        fi
      ''}";

      Type = "oneshot";
      Restart = "on-failure";
      RestartSec = "1s";
    };
  };
}
