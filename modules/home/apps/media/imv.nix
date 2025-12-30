{
  config,
  lib,
  ...
}:
let
  cfg = config.features.apps.media.imv;
in
{
  options.features.apps.media.imv = {
    enable = lib.mkEnableOption "Imv Image viewer";
  };
  config = lib.mkIf cfg.enable {
    programs.imv.enable = true;
    catppuccin.imv.enable = true;

    xdg.mimeApps.defaultApplications = {
      "image/jpeg" = "imv.desktop";
      "image/png" = "imv.desktop";
      "image/gif" = "imv.desktop";
      "image/webp" = "imv.desktop";
      "image/bmp" = "imv.desktop";
      "image/tiff" = "imv.desktop";
      "image/svg+xml" = "imv.desktop";
    };
  };
}
