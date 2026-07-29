{ config, inputs, ... }:
let
  secrets = builtins.toString inputs.secrets;
in
{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
    inputs.catppuccin.homeModules.catppuccin

    ../../../modules/home/system/dotfiles.nix

    "${inputs.secrets}/home.nix"
  ];

  home = {
    username = "rami";
    homeDirectory = "/home/rami";
    enableNixpkgsReleaseCheck = false;
    stateVersion = "26.05";
  };

  sops = {
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    defaultSopsFile = "${secrets}/users/${config.home.username}.yaml";
    validateSopsFiles = true;
  };

  dotfiles = {
    root = "${config.home.homeDirectory}/.dotfiles";
    mutable = false;
  };
}
