{
  imports = [
    common/core

    common/optional/terminals/ghostty.nix
    common/optional/terminals/wezterm.nix
    common/optional/desktops/fonts.nix
    common/optional/shell/zsh.nix
    common/optional/mux/tmux.nix

    common/optional/cli
    common/optional/dev
  ];

  hostSpec = {
    username = "vault";
    home = "/home/vault";
  };
}
