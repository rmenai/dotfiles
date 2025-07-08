{pkgs, ...}: {
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

  hostSpec = {
    username = "vault";
    home = "/home/vault";
  };

  home.packages = with pkgs; [
    ani-cli
  ];
}
