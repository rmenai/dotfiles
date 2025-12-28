{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.media.ffmpeg;
in
{
  options.features.apps.media.ffmpeg = {
    enable = lib.mkEnableOption "FFmpeg";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.ffmpeg ];
  };
}
