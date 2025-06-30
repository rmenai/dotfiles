{
  lib,
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
      ".zfunc" = lib.mkDefault "shell/.zfunc";
      ".zshrc" = lib.mkDefault "shell/.zshrc";
      ".p10k.zsh" = lib.mkDefault "shell/.p10k.zsh";
      ".profile" = lib.mkDefault "shell/.profile";
    };
  };

  persist = {
    home = {
      # ".local/share/zplug" = lib.mkDefault true;
      # ".cache/fsh" = lib.mkDefault true;
      # ".cache/p10k-${config.hostSpec.username}" = lib.mkDefault true;
    };
  };

  # # Edge case, add single file persistence
  # home.file = {
  #   ".cache/p10k-dump-${hostSpec.username}.zsh" = {
  #     source = config.lib.file.mkOutOfStoreSymlink "/persist${config.home.homeDirectory}/.cache/p10k-dump-${hostSpec.username}.zsh";
  #     force = true;
  #   };
  #   ".cache/p10k-dump-${hostSpec.username}.zsh.zwc" = {
  #     source = config.lib.file.mkOutOfStoreSymlink "/persist${config.home.homeDirectory}/.cache/p10k-dump-${hostSpec.username}.zsh.zwc";
  #     force = true;
  #   };
  #   ".cache/p10k-instant-prompt-${hostSpec.username}.zsh" = {
  #     source = config.lib.file.mkOutOfStoreSymlink "/persist${config.home.homeDirectory}/.cache/p10k-instant-prompt-${hostSpec.username}.zsh";
  #     force = true;
  #   };
  #   ".cache/p10k-instant-prompt-${hostSpec.username}.zsh.zwc" = {
  #     source = config.lib.file.mkOutOfStoreSymlink "/persist${config.home.homeDirectory}/.cache/p10k-instant-prompt-${hostSpec.username}.zsh.zwc";
  #     force = true;
  #   };
  # };
}
