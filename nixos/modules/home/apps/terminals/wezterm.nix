{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  options.features.apps.terminals.wezterm = {
    enable = lib.mkEnableOption "WezTerm terminal emulator";
  };

  config = lib.mkIf config.features.apps.terminals.wezterm.enable {
    programs.wezterm = {
      enable = true;
      package = inputs.wezterm.packages.${pkgs.system}.default;
    };

    features.dotfiles = {
      paths = {
        ".config/wezterm" = lib.mkDefault "wezterm";
      };
    };
  };
}
