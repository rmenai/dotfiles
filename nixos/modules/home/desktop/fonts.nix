{ config, lib, pkgs, ... }: {
  options.features.desktop.fonts = {
    enable = lib.mkEnableOption "Desktop fonts";
  };

  config = lib.mkIf config.features.desktop.fonts.enable {
    home.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
      nerd-fonts.noto
      font-awesome
      font-manager
    ];

    fonts.fontconfig.enable = true;
  };
}
