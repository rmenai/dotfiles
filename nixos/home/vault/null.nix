{ lib, ... }: {
  imports = lib.flatten [
    # Core modules.
    (map lib.custom.relativeToRoot [ "modules/common" "modules/home" ])
  ];

  # common/core
  #
  # common/optional/desktops/hyprland.nix
  # common/optional/browsers/brave.nix
  # common/optional/terminals/wezterm.nix
  # common/optional/terminals/kitty.nix
  # common/optional/shell/zsh.nix
  # common/optional/shell/nushell.nix
  # common/optional/mux/tmux.nix
  #
  # common/optional/tools
  # common/optional/comms
  # common/optional/cli
  # common/optional/dev

  spec = {
    user = "vault";
    handle = "rmenai";
    userFullName = "Rami Menai";
    email = "rami@menai.me";
  };

  features = {
    profiles = { core.enable = true; };

    # impermanence.enable = true;
    # dotfiles.enable = true;
  };
}
