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
    home.shellAliases = {
      t = "tmux";
      ta = "tmux attach";
      tad = "tmux attach -d -t";
      tkss = "tmux kill-session -t";
      tksv = "tmux kill-server";
      tl = "tmux list-sessions";
      ts = "tmux new-session -s";
    };

    programs.tmux = {
      enable = true;

      terminal = "tmux-256color";
      baseIndex = 1;
      mouse = false;
      prefix = "C-Space";
      keyMode = "vi";

      plugins = with pkgs.tmuxPlugins; [
        sensible
        yank
        open
        catppuccin
      ];

      extraConfig = ''
        # Options to make tmux more pleasant
        set-option -a terminal-features "xterm-256color:RGB"
        set -g detach-on-destroy off

        # Fixes weirdness
        set -g default-command $SHELL

        # Fix yazi image preview
        set -g allow-passthrough all
        set -ga update-environment TERM
        set -ga update-environment TERM_PROGRAM

        # Rebind splits
        unbind s
        bind a choose-session
        bind c new-window -c '#{pane_current_path}'
        bind s split-window -v -c '#{pane_current_path}'
        bind v split-window -h -c '#{pane_current_path}'
        bind-key x kill-pane

        # Copy mode bindings
        bind-key -T copy-mode-vi v send-keys -X begin-selection
        bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
      '';
    };
  };
}
