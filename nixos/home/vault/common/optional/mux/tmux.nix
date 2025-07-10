{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    tmux
    sesh
  ];

  features.dotfiles = {
    paths = {
      ".config/tmux" = lib.mkDefault "tmux";
      ".config/sesh" = lib.mkDefault "sesh";
    };
  };
}
