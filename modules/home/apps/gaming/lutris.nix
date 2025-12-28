{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.gaming.lutris;
in
{
  options.features.apps.gaming.lutris = {
    enable = lib.mkEnableOption "Lutris gaming platform";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.lutris ];

    # xdg.desktopEntries."net.lutris.Lutris" = {
    #   name = "Lutris";
    #   comment = "Open Gaming Platform";
    #   exec = "gamerun lutris %U";
    #   icon = "lutris";
    #   terminal = false;
    #   type = "Application";
    #   categories = [
    #     "Game"
    #     "Network"
    #   ];
    #   mimeType = [ "application/x-lutris-installer" ];
    #   startupNotify = true;
    # };
  };
}
