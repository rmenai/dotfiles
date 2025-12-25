{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.media.krita;
in
{
  options.features.apps.media.krita = {
    enable = lib.mkEnableOption "Krita";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.krita ];
  };
}
