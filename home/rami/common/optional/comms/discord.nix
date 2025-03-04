{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    discord
  ];

  persist = {
    home = {
      ".config/discord" = lib.mkDefault true;
    };
  };
}
