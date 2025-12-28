{ config, lib, ... }:
let
  cfg = config.features.apps.tools.fzf;
in
{
  options.features.apps.tools.fzf = {
    enable = lib.mkEnableOption "FZF fuzzy finder";
  };

  config = lib.mkIf cfg.enable {
    programs.fzf = {
      enable = true;
      enableBashIntegration = true;
      tmux.enableShellIntegration = true;
    };
  };
}
