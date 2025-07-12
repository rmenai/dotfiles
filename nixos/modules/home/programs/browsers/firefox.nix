{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    firefox
  ];

  features.dotfiles = {
    paths = {
      ".config/chrome" = lib.mkDefault "chrome";
    };
  };
}
