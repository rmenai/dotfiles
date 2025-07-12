{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    discord
  ];

  features.dotfiles = {
    paths = {
      ".config/BetterDiscord" = lib.mkDefault "BetterDiscord";
    };
  };
}
