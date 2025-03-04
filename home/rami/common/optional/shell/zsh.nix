{
  lib,
  hostSpec,
  config,
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
      ".cache/zinit" = lib.mkDefault true;
    };
  };

  # Edge case, add single file persistence
  home.file = {
    ".cache/p10k-dump-${hostSpec.username}.zsh".source = config.lib.file.mkOutOfStoreSymlink "/persist${config.home.homeDirectory}/.cache/p10k-dump-${hostSpec.username}.zsh";
    ".cache/p10k-dump-${hostSpec.username}.zsh.zwc".source = config.lib.file.mkOutOfStoreSymlink "/persist${config.home.homeDirectory}/.cache/p10k-dump-${hostSpec.username}.zsh.zwc";
    ".cache/p10k-instant-prompt-${hostSpec.username}.zsh".source = config.lib.file.mkOutOfStoreSymlink "/persist${config.home.homeDirectory}/.cache/p10k-instant-prompt-${hostSpec.username}.zsh";
    ".cache/p10k-instant-prompt-${hostSpec.username}.zsh.zwc".source = config.lib.file.mkOutOfStoreSymlink "/persist${config.home.homeDirectory}/.cache/p10k-instant-prompt-${hostSpec.username}.zsh.zwc";
  };
}
