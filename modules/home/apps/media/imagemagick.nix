{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.media.imagemagick;
in
{
  options.features.apps.media.imagemagick = {
    enable = lib.mkEnableOption "ImageMagick image manipulation tool";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.imagemagick ];
  };
}
