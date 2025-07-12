{ config, lib, ... }: {
  options.features.apps.terminals.zellij = {
    enable = lib.mkEnableOption "Zellij terminal multiplexer";
  };

  config = lib.mkIf config.features.apps.terminals.zellij.enable {
    programs.zellij = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };

    features.dotfiles = {
      paths = { ".config/zellij" = lib.mkDefault "zellij"; };
    };
  };
}
