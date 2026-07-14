{ pkgs, ... }:
{
  home.shellAliases = {
    fzfp = "fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'";
  };

  programs.fzf = {
    enable = true;
    package = pkgs.unstable.fzf;
    enableBashIntegration = true;
    tmux.enableShellIntegration = true;
    historyWidget.nushell.command = "";
  };

  catppuccin.fzf.enable = true;
}
