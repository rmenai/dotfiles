{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.features.apps.dev.shell;
in
{
  options.features.apps.dev.shell = {
    enable = lib.mkEnableOption "Shell tools";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.shellharden ];
  };
}
