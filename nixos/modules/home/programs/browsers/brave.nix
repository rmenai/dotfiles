{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    brave
  ];

  features.dotfiles = {
    paths = {
      ".config/chrome" = lib.mkDefault "chrome";
    };
  };
}
