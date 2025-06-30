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

  persist = {
    home = {
      # ".config/BraveSoftware/Brave-Browser" = lib.mkDefault true;
      # ".cache/BraveSoftware/Brave-Browser" = lib.mkDefault true;
    };
  };
}
