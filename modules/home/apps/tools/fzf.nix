{ config, lib, ... }:
let
  cfg = config.features.apps.tools.fzf;
in
{
  options.features.apps.tools.fzf = {
    enable = lib.mkEnableOption "FZF fuzzy finder";
  };

  config = lib.mkIf cfg.enable {
    home.shellAliases = {
      fzfp = "fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'";
    };

    programs.fzf = {
      enable = true;
      enableBashIntegration = true;
      tmux.enableShellIntegration = true;
    };

    catppuccin.fzf.enable = true;
  };
}
