{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.media.ani-cli;
in
{
  options.features.apps.media.ani-cli = {
    enable = lib.mkEnableOption "ani-cli anime viewer";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.ani-cli ];
  };
}
