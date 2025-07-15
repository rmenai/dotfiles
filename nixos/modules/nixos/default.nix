{ inputs, ... }: {
  imports = [
    inputs.impermanence.nixosModules.impermanence
    inputs.lanzaboote.nixosModules.lanzaboote
    inputs.disko.nixosModules.disko
    inputs.home-manager.nixosModules.home-manager
    inputs.sops-nix.nixosModules.sops

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
