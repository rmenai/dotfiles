{ config, pkgs, inputs, ... }:

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
      ".local/share/keyrings"
      ".local/share/direnv"
      ".local/share/yadm"
      ".config/git"
      ".config/hypr"
      ".config/bat"
      ".config/btop"
      ".config/yazi"
      ".config/sesh"
      ".config/tmux"
      ".config/nvim"

      ".config/utop"
      ".config/rust-competitive-helper"
    ];
    allowOther = true;
  };
}
