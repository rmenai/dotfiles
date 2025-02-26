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
      ".mozilla"
      ".local/share/keyrings"
      ".local/share/direnv"
      ".local/share/yadm"
      # ".config/git"
    ];
    allowOther = true;
  };
}
