{
  lib,
  hostSpec,
  ...
}: {
  programs.zsh = {
    enable = true;
  };

  dotfiles = {
    files = {
      ".config/zsh" = lib.mkDefault "zsh";
      ".config/fsh" = lib.mkDefault "fsh";
      ".zshrc" = lib.mkDefault "shell/.zshrc";
      ".p10k.zsh" = lib.mkDefault "shell/.p10k.zsh";
      ".profile" = lib.mkDefault "shell/.profile";
    };
  };
  persist = {
    home = {
      ".local/share/zinit" = lib.mkDefault true;
      ".cache/fsh" = lib.mkDefault true;
      ".cache/p10k-${hostSpec.username}" = lib.mkDefault true;
    };
  };
}
