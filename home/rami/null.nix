{
  imports = [
    common/core

    common/optional/desktops/hyprland.nix
    common/optional/browsers/brave.nix
    common/optional/terminals/wezterm.nix
    common/optional/shell/zsh.nix
    common/optional/mux/tmux.nix

    common/optional/tools
    common/optional/comms
    common/optional/cli
    common/optional/dev
  ];

  # dotfiles = {
  #   files = {
  #     ".config/nvim" = "";
  #   };
  # };
}
