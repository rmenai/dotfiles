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
      ".vimgolf" = lib.mkDefault true;
    };
  };
}
