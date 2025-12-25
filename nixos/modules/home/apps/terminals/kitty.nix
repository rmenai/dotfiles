{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.terminals.kitty;
in
{
  options.features.apps.terminals.kitty = {
    enable = lib.mkEnableOption "Kitty terminal emulator";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.kitty ];

    features.core.dotfiles.links.kitty = "kitty";
  };
}
