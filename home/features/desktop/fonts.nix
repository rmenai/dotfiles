{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.desktop.fonts;
in {
  options.features.desktop.fonts.enable = mkEnableOption "Install fonts";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      jetbrains-mono
      font-awesome
      font-manager
      noto-fonts
    ];
  };
}
