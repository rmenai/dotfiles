{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.desktop.wayland;
in {
  options.features.desktop.wayland.enable = mkEnableOption "Wayland config";

  programs.waybar.enable = true;

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # grim # Screenshot
      # hyprlock # Lockscreen
      # slurp # With grim
      #
      # ... # For other wayland
    ];
  };
}
