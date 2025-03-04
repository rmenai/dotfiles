{lib, ...}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  dotfiles = {
    files = {
      ".config/nvim" = lib.mkDefault "nvim";
    };
  };

  persist = {
    home = {
      ".local/share/nvim" = lib.mkDefault true;
      ".local/state/nvim" = lib.mkDefault true;
      ".cache/nvim" = lib.mkDefault true;
    };
  };
}
