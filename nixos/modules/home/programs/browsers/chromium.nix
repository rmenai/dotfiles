{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    chromium
  ];

  features.dotfiles = {
    paths = {
      ".config/chrome" = lib.mkDefault "chrome";
    };
  };
}
