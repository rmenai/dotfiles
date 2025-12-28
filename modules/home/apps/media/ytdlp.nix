{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.media.ytdlp;
in
{
  options.features.apps.media.ytdlp = {
    enable = lib.mkEnableOption "yt-dlp";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.yt-dlp ];
  };
}
