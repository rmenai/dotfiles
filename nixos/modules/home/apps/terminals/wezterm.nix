{ config, lib, pkgs, ... }: {
  options.features.apps.terminals.wezterm = {
    enable = lib.mkEnableOption "WezTerm terminal emulator";
  };

  config = lib.mkIf config.features.apps.terminals.wezterm.enable {
    home.packages = [ pkgs.wezterm ];

    features.dotfiles = {
      paths = { ".config/wezterm" = lib.mkDefault "wezterm"; };
    };
  };
}
