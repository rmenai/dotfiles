{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.dev.node;
in
{
  options.features.apps.dev.node = {
    enable = lib.mkEnableOption "Node.js development tools";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.volta ];
    home.sessionPath = [ "~/.volta/bin" ];
  };
}
