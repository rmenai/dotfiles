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
    services.swayidle = {
      systemdTarget = "graphical-session.target";

      extraArgs = [ "-w" ];

      events = {
        "lock" = "${pkgs.swaylock-effects}/bin/swaylock -f";
        "before-sleep" = "${pkgs.systemd}/bin/loginctl lock-session";
      };

      timeouts = [
        # 2.5 Minutes: Dim screen
        {
          timeout = 150;
          command = "${pkgs.brightnessctl}/bin/brightnessctl -s set 10"; # Save state and dim
          resumeCommand = "${pkgs.brightnessctl}/bin/brightnessctl -r"; # Restore state
        }

        # 5 Minutes: Lock screen
        {
          timeout = 300;
          command = "${pkgs.systemd}/bin/loginctl lock-session";
        }

        # 5.5 Minutes: Turn off screens
        {
          timeout = 330;
          command = "niri msg action power-off-monitors";
        }
      ];
    };
  };
}
