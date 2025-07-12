{ config, lib, pkgs, ... }: {
  options.features.apps.terminals.tmux = {
    enable = lib.mkEnableOption "Tmux terminal multiplexer";
  };

  config = lib.mkIf config.features.apps.terminals.tmux.enable {
    home.packages = with pkgs; [ tmux sesh ];

    features.dotfiles = {
      paths = {
        ".config/tmux" = lib.mkDefault "tmux";
        ".config/sesh" = lib.mkDefault "sesh";
      };
    };
  };
}
