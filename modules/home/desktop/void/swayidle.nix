{ pkgs, ... }:
let
  lock = "${pkgs.swaylock-effects}/bin/swaylock -f";
  display = status: "${pkgs.niri}/bin/niri msg action power-${status}-monitors";
in
{
  services.swayidle = {
    extraArgs = [ "-w" ];
    # systemdTarget = "graphical-session.target";

    events = {
      "before-sleep" = (display "off") + "; " + lock;
      "after-resume" = display "on";
      "lock" = (display "off") + "; " + lock;
      "unlock" = display "on";
    };

    timeouts = [
      {
        timeout = 150;
        command = "${pkgs.brightnessctl}/bin/brightnessctl -s set 10"; # Save state and dim
        resumeCommand = "${pkgs.brightnessctl}/bin/brightnessctl -r"; # Restore state
      }

      {
        timeout = 300;
        command = display "off";
        resumeCommand = display "on";
      }

      {
        timeout = 600;
        command = lock;
      }

      {
        timeout = 1200;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
  };
}
