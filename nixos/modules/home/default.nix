{ inputs, ... }:
{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
    inputs.sops-nix.homeManagerModules.sops
    inputs.catppuccin.homeModules.catppuccin

    "${inputs.secrets}/home.nix"

    ./system
    ./services
    ./desktop
    ./apps
    ./profiles
  ];
}
