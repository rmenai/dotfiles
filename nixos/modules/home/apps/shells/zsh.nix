{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.shells.zsh;
in
{
  options.features.apps.shells.zsh = {
    enable = lib.mkEnableOption "Zsh shell";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ zsh ];

    features.core.dotfiles.links.zsh = "zsh";

    features.core.dotfiles.homeLinks = {
      ".zfunc" = "shell/.zfunc";
      ".zshrc" = "shell/.zshrc";
      ".p10k.zsh" = "shell/.p10k.zsh";
      ".profile" = "shell/.profile";
    };
  };
}
