{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.browsers.firefox;
in
{
  options.features.apps.browsers.firefox = {
    enable = lib.mkEnableOption "Firefox browser";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.firefox ];
  };
}
