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
    programs.swayimg = {
      enable = true;
      settings = {
        viewer = {
          window = "00000000";
          transparency = "00000000";
          scale = "optimal";
        };

        info = {
          show = "no";
        };
      };
    };

    xdg.mimeApps.defaultApplications = {
      "image/jpeg" = "swayimg.desktop";
      "image/png" = "swayimg.desktop";
      "image/gif" = "swayimg.desktop";
      "image/webp" = "swayimg.desktop";
      "image/bmp" = "swayimg.desktop";
      "image/tiff" = "swayimg.desktop";
      "image/svg+xml" = "swayimg.desktop";
    };
  };
}
