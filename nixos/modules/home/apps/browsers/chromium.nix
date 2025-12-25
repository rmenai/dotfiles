{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.browsers.chromium;
in
{
  options.features.apps.browsers.chromium = {
    enable = lib.mkEnableOption "Chromium browser";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.chromium ];

    features.core.dotfiles.links.chrome = "chrome";
  };
}
