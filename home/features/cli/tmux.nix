{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.features.cli.tmux;
in {
  options.features.cli.tmux.enable = mkEnableOption "Enable tmux configuration";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      tmux
      sesh
    ];
  };
}
