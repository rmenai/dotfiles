{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    firefox
  ];
  dotfiles = {
    files = {
      ".config/chrome" = lib.mkDefault "chrome";
    };
  };
}
