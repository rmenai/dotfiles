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
      nerd-fonts.ubuntu
      nerd-fonts.jetbrains-mono
      nerd-fonts.commit-mono
      noto-fonts-color-emoji
      sarasa-gothic
    ];

    fonts.fontconfig = {
      enable = true;

      defaultFonts = {
        serif = [
          "Sarasa Gothic J"
          "Noto Color Emoji"
        ];

        sansSerif = [
          "Ubuntu Nerd Font"
          "Sarasa Gothic J"
          "Noto Color Emoji"
        ];

        monospace = [
          "JetBrainsMono Nerd Font"
          "Sarasa Mono J"
          "Noto Color Emoji"
        ];

        emoji = [
          "Noto Color Emoji"
        ];
      };
    };
  };
}
