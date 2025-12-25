{ config, lib, ... }:
let
  cfg = config.features.apps.terminals.zellij;
in
{
  options.features.apps.terminals.zellij = {
    enable = lib.mkEnableOption "Zellij terminal multiplexer";
  };

  config = lib.mkIf cfg.enable {
    programs.zellij = {
      enable = true;
      enableBashIntegration = true;
    };

    features.core.dotfiles.links.zellij = "zellij";
  };
}
