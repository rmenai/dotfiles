{pkgs, ...}: {
  systemd.user.services.hyprland-set-highres = {
    Unit = {
      Description = "Set high resolution in Hyprland";
      After = ["hyprland.service"];
    };
    Install = {
      WantedBy = ["default.target"];
    };
    Service = {
      ExecStart = "${pkgs.hyprland}/bin/hyprctl keyword monitor 'eDP-1, highres@highrr, 0x0, 1'";
    };
  };

  systemd.user.services.hyprland-set-battery = {
    Unit = {
      Description = "Set battery resolution in Hyprland";
      After = ["hyprland.service"];
    };
    Install = {
      WantedBy = ["default.target"];
    };
    Service = {
      ExecStart = "${pkgs.hyprland}/bin/hyprctl keyword monitor 'eDP-1, 1920x1200@60, 0x0, 1'";
    };
  };
}
