{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.media.mpv;
in
{
  options.features.apps.media.mpv = {
    enable = lib.mkEnableOption "MPV Media Player";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.mpv ];

    xdg.mimeApps.defaultApplications = {
      # Video files
      "video/mp4" = "mpv.desktop";
      "video/x-msvideo" = "mpv.desktop";
      "video/quicktime" = "mpv.desktop";
      "video/x-matroska" = "mpv.desktop";
      "video/webm" = "mpv.desktop";
      "video/x-flv" = "mpv.desktop";
      "video/x-ms-wmv" = "mpv.desktop";

      # Audio files
      "audio/mpeg" = "mpv.desktop";
      "audio/mp4" = "mpv.desktop";
      "audio/x-wav" = "mpv.desktop";
      "audio/x-flac" = "mpv.desktop";
      "audio/ogg" = "mpv.desktop";
      "audio/x-vorbis+ogg" = "mpv.desktop";
    };
  };

  # catppuccin.mpv.enable = true;
}
