{ inputs, ... }: {
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
    inputs.sops-nix.homeManagerModules.sops
    inputs.catppuccin.homeModules.catppuccin

    ./system
    ./services
    ./desktop
    ./apps
    ./profiles
  ];
}
