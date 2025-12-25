{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.browsers.brave;
in
{
  options.features.apps.browsers.brave = {
    enable = lib.mkEnableOption "Brave browser";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.brave ];
  };
}
