{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.terminals.tmux;
in
{
  options.features.apps.terminals.tmux = {
    enable = lib.mkEnableOption "Tmux terminal multiplexer";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      tmux
      sesh
    ];

    features.core.dotfiles.links = {
      tmux = "tmux";
      sesh = "sesh";
    };
  };
}
