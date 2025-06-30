{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    discord
  ];

  dotfiles = {
    files = {
      ".config/BetterDiscord" = lib.mkDefault "BetterDiscord";
    };
  };
}
