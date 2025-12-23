{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.features.desktop.fonts = {
    enable = lib.mkEnableOption "desktop fonts configuration";
  };

  config = lib.mkIf config.features.desktop.fonts.enable {
    fonts.packages = with pkgs; [
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
    ];
  };
}
