{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.terminals.wezterm;
in
{
  options.features.apps.terminals.wezterm = {
    enable = lib.mkEnableOption "WezTerm terminal emulator";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.wezterm ];

    features.core.dotfiles.links.wezterm = "wezterm";
  };
}
