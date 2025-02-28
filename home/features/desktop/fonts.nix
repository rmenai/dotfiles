{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.desktop.fonts;
in {
  options.features.desktop.wayland.enable = mkEnableOption "Install fonts";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      jetbrains-mono
    ];
  };
}
