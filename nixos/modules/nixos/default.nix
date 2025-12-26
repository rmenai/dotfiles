{ lib, inputs, ... }:
{
  imports = [
    inputs.nixos-generators.nixosModules.all-formats
    inputs.impermanence.nixosModules.impermanence
    inputs.lanzaboote.nixosModules.lanzaboote
    inputs.disko.nixosModules.disko
    inputs.home-manager.nixosModules.home-manager
    inputs.sops-nix.nixosModules.sops
    inputs.nix-index-database.nixosModules.nix-index
    inputs.microvm.nixosModules.host

    inputs.catppuccin.nixosModules.catppuccin
    inputs.niri.nixosModules.niri

    "${inputs.secrets}/nixos.nix"
  ]
  # Auto-import modules from specific subdirectories
  ++ (lib.concatMap
    (
      dir:
      lib.pipe dir [
        lib.filesystem.listFilesRecursive
        (map toString)
        (lib.filter (lib.strings.hasSuffix ".nix"))
      ]
    )
    [
      ./apps
      ./core
      ./desktop
      ./hardware
      ./profiles
      ./services
      ./users
    ]
  );
}
