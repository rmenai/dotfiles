{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.desktop.waybar;
in
{
  options.features.desktop.waybar = {
    enable = lib.mkEnableOption "Waybar";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      waybar

      bluez
      brightnessctl
      networkmanager
      pulseaudio
      fzf
    ];

    features.core.dotfiles.links.waybar = "waybar";
  };
}
