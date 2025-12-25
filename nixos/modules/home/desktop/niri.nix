{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.desktop.niri;
in
{
  options.features.desktop.niri = {
    enable = lib.mkEnableOption "niri";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      wl-clipboard
      alacritty
      cliphist
      matugen
      cava
    ];

    programs = {
      waybar.enable = true;
      fuzzel.enable = true;
    };

    features.core.dotfiles.links = {
      niri = "niri";
    };
  };
}
