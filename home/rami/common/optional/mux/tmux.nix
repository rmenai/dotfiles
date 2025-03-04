{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    tmux
    sesh
  ];

  dotfiles = {
    files = {
      ".config/tmux" = lib.mkDefault "tmux";
      ".config/sesh" = lib.mkDefault "sesh";
    };
  };

  persist = {
    home = {
      ".local/share/tmux" = lib.mkDefault true;
    };
  };
}
