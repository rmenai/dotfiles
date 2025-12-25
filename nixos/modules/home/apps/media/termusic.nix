{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.media.termusic;
in
{
  options.features.apps.media.termusic = {
    enable = lib.mkEnableOption "Termusic terminal music player";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.termusic ];
  };
}
