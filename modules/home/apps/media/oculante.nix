{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.media.oculante;
in
{
  options.features.apps.media.oculante = {
    enable = lib.mkEnableOption "Oculante Image Viewer";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.oculante ];

    # xdg.mimeApps.defaultApplications = {
    #   "image/jpeg" = "oculante.desktop";
    #   "image/png" = "oculante.desktop";
    #   "image/gif" = "oculante.desktop";
    #   "image/webp" = "oculante.desktop";
    #   "image/tiff" = "oculante.desktop";
    #   "image/bmp" = "oculante.desktop";
    #   "image/svg+xml" = "oculante.desktop";
    # };
  };
}
