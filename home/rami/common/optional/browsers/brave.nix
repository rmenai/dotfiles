{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    brave
  ];

  dotfiles = {
    files = {
      ".config/chrome" = lib.mkDefault "chrome";
    };
  };
}
