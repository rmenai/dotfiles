{ inputs, ... }:
{
  imports = [
    inputs.nixos-generators.nixosModules.all-formats
    inputs.impermanence.nixosModules.impermanence
    inputs.lanzaboote.nixosModules.lanzaboote
    inputs.disko.nixosModules.disko
    inputs.home-manager.nixosModules.home-manager
    inputs.sops-nix.nixosModules.sops
    inputs.catppuccin.nixosModules.catppuccin

    "${inputs.secrets}/nixos.nix"

    ./apps
    ./boot
    ./containers
    ./desktop
    ./display
    ./hardware
    ./profiles
    ./services
    ./system
    ./users
  ];
}
