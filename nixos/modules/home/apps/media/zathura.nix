{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.media.zathura;
in
{
  options.features.apps.media.zathura = {
    enable = lib.mkEnableOption "Zathura PDF viewer";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ zathura ];

    xdg.mimeApps.defaultApplications = {
      "application/pdf" = "org.pwmt.zathura-pdf-mupdf.desktop";
      "application/x-pdf" = "org.pwmt.zathura-pdf-mupdf.desktop";
    };

    features.core.dotfiles.links.zathura = "zathura";
  };
}
