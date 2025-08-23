{ config, lib, pkgs, ... }: {
  options.features.apps.gaming.lutris = {
    enable = lib.mkEnableOption "Lutris gaming platform";
  };

  config = lib.mkIf config.features.apps.gaming.lutris.enable {
    home.packages = [ pkgs.lutris ];

    xdg.desktopEntries."net.lutris.Lutris" = {
      name = "Lutris";
      comment = "Open Gaming Platform";
      exec = "gamerun lutris %U";
      icon = "lutris";
      terminal = false;
      type = "Application";
      categories = [ "Game" "Network" ];
      mimeType = [ "application/x-lutris-installer" ];
      startupNotify = true;
    };
  };
}
