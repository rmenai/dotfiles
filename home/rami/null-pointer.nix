{ config, ... }:
{
  imports = [
    ../features/cli
    ../common
    ./home.nix
    ./impermanence.nix
  ];

  home.shellAliases = {
    nrs = "sudo nixos-rebuild switch --flake /etc/nixos#null-pointer";
    nrb = "sudo nixos-rebuild boot --flake /etc/nixos#null-pointer";
    nrt = "sudo nixos-rebuild test --flake /etc/nixos#null-pointer";
  };
}
