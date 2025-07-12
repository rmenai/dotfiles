{lib, ...}: {
  programs.zsh = {
    enable = true;
  };

  features.dotfiles = {
    paths = {
      ".config/zsh" = lib.mkDefault "zsh";
      ".config/fsh" = lib.mkDefault "fsh";
      ".zfunc" = lib.mkDefault "shell/.zfunc";
      ".zshrc" = lib.mkDefault "shell/.zshrc";
      ".p10k.zsh" = lib.mkDefault "shell/.p10k.zsh";
    };
  };
}
