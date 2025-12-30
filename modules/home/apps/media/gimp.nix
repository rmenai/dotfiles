{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.media.gimp;
in
{
  options.features.apps.media.gimp = {
    enable = lib.mkEnableOption "Gimp";
  };
  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.gimp ];

    xdg.mimeApps.defaultApplications = {
      "image/x-xcf" = "gimp.desktop";
    };
  };
}
