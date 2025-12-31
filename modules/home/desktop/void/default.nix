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
  options.features.desktop.void = {
    enable = lib.mkEnableOption "Void theme";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      wl-clipboard
      brightnessctl
      networkmanager
      pulseaudio
      libnotify
      bluez

      networkmanager_dmenu
      rofi-power-menu
      rofi-bluetooth
      libqalculate
      rofi-calc
      rofimoji

      tesseract
      hyprpicker
      nautilus
    ];

    programs = {
      # niri.enable = true;  Handled by flake
      waybar.enable = true;
      rofi.enable = true;
      satty.enable = true;
      swaylock.enable = true;
    };

    services = {
      cliphist.enable = true;
      swayidle.enable = true;
      swayosd.enable = true;
      swaync.enable = true;
      swww.enable = true;
    };
  };
}
