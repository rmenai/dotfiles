{
  lib,
  pkgs,
  ...
}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  home.packages = [
    pkgs.vimgolf
  ];

  features.dotfiles = {
    paths = {
      ".config/nvim" = lib.mkDefault "nvim";
    };
  };

  features.persist = {
    directories = {
      ".vimgolf" = lib.mkDefault true;
    };
  };
}
