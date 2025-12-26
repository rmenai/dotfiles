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
      iosevka
      nerd-fonts.iosevka
      nerd-fonts.commit-mono
      noto-fonts-color-emoji
      sarasa-gothic
    ];
  };
}
