{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    kitty
  ];

  dotfiles = {
    files = {
      ".config/kitty" = lib.mkDefault "kitty";
    };
  };
}
