{
  imports = [
    common/core

    common/optional/services/sops.nix
    common/optional/services/persist.nix
    common/optional/services/mpris.nix

    common/optional/desktops/hyprland.nix
    common/optional/browsers/brave.nix
    common/optional/terminals/wezterm.nix
    common/optional/terminals/kitty.nix
    common/optional/shell/zsh.nix
    common/optional/shell/nushell.nix
    common/optional/mux/tmux.nix

    common/optional/tools
    common/optional/comms
    common/optional/cli
    common/optional/dev
  ];

  spec = {
    user = "vault";
    handle = "rmenai";
    userFullName = "Rami Menai";
    email = "rami@menai.me";
  };

  features = {
    impermanence.enable = true;
    persist.enable = true;
    dotfiles.enable = true;
  };
}
