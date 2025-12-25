{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.gaming.heroic;
in
{
  options.features.apps.gaming.heroic = {
    enable = lib.mkEnableOption "Heroic Games Launcher";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.heroic ];

    # xdg.desktopEntries."com.heroicgameslauncher.hgl" = {
    #   name = "Heroic Games Launcher";
    #   comment = "Native GOG, Epic, and Amazon Games Launcher for Linux";
    #   exec = "gamerun heroic %U";
    #   icon = "com.heroicgameslauncher.hgl";
    #   terminal = false;
    #   type = "Application";
    #   categories = [
    #     "Game"
    #     "Network"
    #   ];
    #   startupNotify = true;
    # };
  };
}
