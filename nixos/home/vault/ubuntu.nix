{
  imports = [
    common/core

    common/optional/shell/zsh.nix
    common/optional/mux/tmux.nix

    common/optional/cli
    common/optional/dev
  ];

  spec = {
    user = builtins.getEnv "USER";
  };
}
