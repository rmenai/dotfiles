{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.desktop.hyprland;
in
{
  options.features.desktop.hyprland = {
    enable = lib.mkEnableOption "Hyprland Desktop Environment";
  };

  config = lib.mkIf cfg.enable {
    programs.waybar.enable = true;

    home.packages = with pkgs; [
      hyprlock
      hyprpaper
      hypridle
      hyprsunset
      dunst
      libnotify
      pamixer
      brightnessctl

      (rofi.override { plugins = [ pkgs.rofi-emoji ]; })
      swaylock-effects
      sddm-sugar-dark
      rofi-emoji
      hyprpicker
      eww

      alsa-utils
      mpc

      slurp
      # kdePackages.xwaylandvideobridge
      kdePackages.xdg-desktop-portal-kde
      xdg-desktop-portal
      grim
      qt6.qtwayland
      wl-mirror
      wl-clipboard
      cliphist
      wlogout
      wtype
    ];

    xdg.portal = {
      enable = true;
      config.common.default = "*";
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };
  };
}
