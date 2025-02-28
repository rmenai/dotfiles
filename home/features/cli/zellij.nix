{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.features.cli.zellij;
in {
  options.features.cli.zellij.enable = mkEnableOption "Enable zellij configuration";
  config = mkIf cfg.enable {
    programs.zellij = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
  };
}
