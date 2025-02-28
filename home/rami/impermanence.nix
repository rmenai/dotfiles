{inputs, ...}: {
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

      ".dotfiles"
      ".gnupg"
      ".ssh"
      ".nixops"
      ".zen"
      ".cargo"
      ".rustup"
      ".opam"
      ".cache"

      ".local/share/keyrings"
      ".local/share/direnv"
      ".local/share/hyprland"
      ".local/share/nvim"
      ".local/share/sddm"
      ".local/share/nvim"
      ".local/share/zinit"
      ".local/share/zoxide"
      ".local/share/tmux"

      ".local/state/home-manager"
      ".local/state/nix"
      ".local/state/nvim"

      ".config/gh"
    ];

    allowOther = true;
  };
}
