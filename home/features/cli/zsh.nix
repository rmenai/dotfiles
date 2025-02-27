{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.features.cli.zsh;
in {
  options.features.cli.zsh.enable = mkEnableOption "Enable zsh configuration";

  config = mkIf cfg.enable {
    programs.zsh.enable = true;
  };
}
