{
  imports = [
    common/core

    common/optional/terminals/kitty.nix
    common/optional/desktops/fonts.nix
    common/optional/shell/zsh.nix
    common/optional/mux/tmux.nix

    common/optional/cli
    common/optional/dev
  ];

  spec = {
    username = "vault";
    home = "/home/vault";
  };
}
