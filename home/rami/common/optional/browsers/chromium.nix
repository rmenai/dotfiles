{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    chromium
  ];

  dotfiles = {
    files = {
      ".config/chrome" = lib.mkDefault "chrome";
    };
  };
}
