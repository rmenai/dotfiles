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

  persist = {
    home = {
      # ".config/chromium" = lib.mkDefault true;
      # ".cache/chromium" = lib.mkDefault true;
    };
  };
}
