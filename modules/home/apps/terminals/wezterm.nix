{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.terminals.wezterm;
  mkLink = config.features.core.dotfiles.mkLink;
in
{
  options.features.apps.terminals.wezterm = {
    enable = lib.mkEnableOption "WezTerm terminal emulator";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.wezterm ];

    xdg.configFile."wezterm".source = mkLink ./wezterm;
  };
}
