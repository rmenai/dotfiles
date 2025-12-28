{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.terminals.ghostty;
in
{
  options.features.apps.terminals.ghostty = {
    enable = lib.mkEnableOption "Ghostty terminal emulator";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.ghostty ];
  };
}
