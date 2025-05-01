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

  persist = {
    home = {
      ".mozilla/firefox" = lib.mkDefault true;
      ".cache/mozilla/firefox" = lib.mkDefault true;
    };
  };
}
