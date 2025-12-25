{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.desktop.fonts;
in
{
  options.features.desktop.fonts = {
    enable = lib.mkEnableOption "Desktop Fonts Configuration";
  };

  config = lib.mkIf cfg.enable {
    fonts.packages = with pkgs; [
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
    ];
  };
}
