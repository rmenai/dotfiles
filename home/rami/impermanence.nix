{ inputs, ... }:

{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];

  home.persistence."/persist/home/rami" = {
    directories = [
      "Downloads"
      "Music"
      "Pictures"
      "Documents"
      "Videos"
      ".gnupg"
      ".ssh"
      ".nixops"
      ".zen"
      ".cargo"
      ".rustup"
      ".cache"

      ".local/share/keyrings"
      ".local/share/direnv"
      ".local/share/yadm"
      ".local/share/hyprland"
      ".local/share/nvim"
      ".local/share/sddm"
      ".local/share/yadm"
      ".local/share/nvim"
      ".local/share/zinit"
      ".local/share/zoxide"
      ".local/share/tmux"

      ".local/state/home-manager"
      ".local/state/nix"
      ".local/state/nvim"

      # ".config/environment.d"
      # ".config/fontconfig"
      # ".config/nix"
      # ".config/systemd"

      ".config/git"
      ".config/hypr"
      ".config/bat"
      ".config/btop"
      ".config/yazi"
      ".config/sesh"
      ".config/nvim"
      ".config/wezterm"
      ".config/zsh"
      ".config/fsh"
      ".config/zellij"
      ".config/tmux"
      ".config/github-copilot"

      ".config/utop"
      ".config/rust-competitive-helper"
    ];

    files = [
      ".profile"
      ".zshrc"
      ".p10k.zsh"
      ".zsh_history"
    ];

    allowOther = true;
  };
}
