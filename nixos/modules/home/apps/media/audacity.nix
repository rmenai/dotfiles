{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.media.audacity;
in
{
  options.features.apps.media.audacity = {
    enable = lib.mkEnableOption "Audacity audio editor";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.audacity ];
  };
}
