{
  imports = [
    common/core

    common/optional/shell/zsh.nix
    common/optional/mux/tmux.nix

    common/optional/cli
    common/optional/dev
  ];

  hostSpec = {
    username = builtins.getEnv "USER";
    home = builtins.getEnv "HOME";
  };
}
