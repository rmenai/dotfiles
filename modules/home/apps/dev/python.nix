{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.dev.python;
in
{
  options.features.apps.dev.python = {
    enable = lib.mkEnableOption "Python development tools";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.uv ];
  };
}
