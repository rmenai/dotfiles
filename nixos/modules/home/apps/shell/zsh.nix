{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.features.apps.shell.zsh = {
    enable = lib.mkEnableOption "Zsh shell";
  };

  config = lib.mkIf config.features.apps.shell.zsh.enable {
    home.packages = with pkgs; [ zsh ];

    features.dotfiles = {
      paths = {
        ".config/zsh" = lib.mkDefault "zsh";
        ".config/fsh" = lib.mkDefault "fsh";
        ".zfunc" = lib.mkDefault "shell/.zfunc";
        ".zshrc" = lib.mkDefault "shell/.zshrc";
        ".p10k.zsh" = lib.mkDefault "shell/.p10k.zsh";
        ".profile" = lib.mkDefault "shell/.profile";
      };
    };
  };
}
