{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.media.kdenlive;
in
{
  options.features.apps.media.kdenlive = {
    enable = lib.mkEnableOption "Kdenlive Video Editor";
  };
  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.kdePackages.kdenlive ];
  };
}
