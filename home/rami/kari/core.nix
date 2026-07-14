{ config, inputs, ... }:
let
  secrets = builtins.toString inputs.secrets;
in
{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
    inputs.catppuccin.homeModules.catppuccin
    inputs.nix-index-database.homeModules.default

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
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/key.txt";
    defaultSopsFile = "${secrets}/users/${config.home.username}.yaml";
    validateSopsFiles = true;
  };

  dotfiles = {
    root = "${config.home.homeDirectory}/.dotfiles";
    mutable = true;
  };

  nixpkgs.config.allowUnfree = true;
  systemd.user.startServices = "sd-switch";
}
