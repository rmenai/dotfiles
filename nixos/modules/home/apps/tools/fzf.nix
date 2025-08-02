{ config, lib, ... }: {
  options.features.apps.tools.fzf = {
    enable = lib.mkEnableOption "FZF fuzzy finder";
  };

  config = lib.mkIf config.features.apps.tools.fzf.enable {
    programs.fzf = {
      enable = true;
      enableBashIntegration = true;
      tmux.enableShellIntegration = true;
    };
  };
}
