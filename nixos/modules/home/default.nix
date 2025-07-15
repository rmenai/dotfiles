{ inputs, ... }: {
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
    inputs.sops-nix.homeManagerModules.sops

    ./system
    ./services
    ./desktop
    ./apps
    ./profiles
  ];
}
