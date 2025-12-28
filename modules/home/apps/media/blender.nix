{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.media.blender;
in
{
  options.features.apps.media.blender = {
    enable = lib.mkEnableOption "Blender 3D modeling software";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ (pkgs.blender.override { cudaSupport = true; }) ];
  };
}
