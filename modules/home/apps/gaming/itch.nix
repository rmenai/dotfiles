{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.gaming.itch;
in
{
  options.features.apps.gaming.itch = {
    enable = lib.mkEnableOption "itch.io desktop app";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.itch ];

    # xdg.desktopEntries."itch" = {
    #   name = "itch";
    #   comment = "Install and play itch.io games easily";
    #   exec = "gamerun itch %U";
    #   icon = "itch";
    #   terminal = false;
    #   type = "Application";
    #   categories = [ "Game" ];
    #   mimeType = [
    #     "x-scheme-handler/itchio"
    #     "x-scheme-handler/itch"
    #   ];
    #   startupNotify = true;
    # };
  };
}
