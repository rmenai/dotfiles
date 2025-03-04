{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    zathura
  ];

  dotfiles = {
    files = {
      ".config/zathura" = lib.mkDefault "zathura";
    };
  };
}
