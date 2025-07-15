{ inputs, ... }: {
  imports = [
    inputs.disko.nixosModules.disko
    inputs.impermanence.nixosModules.impermanence
    inputs.lanzaboote.nixosModules.lanzaboote
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
