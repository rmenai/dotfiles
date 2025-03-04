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
}
