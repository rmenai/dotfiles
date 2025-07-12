{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    kitty
  ];

  features.dotfiles = {
    paths = {
      ".config/kitty" = lib.mkDefault "kitty";
    };
  };
}
