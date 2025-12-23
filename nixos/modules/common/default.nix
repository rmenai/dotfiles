{ inputs, ... }:
{
  imports = [
    "${inputs.secrets}/home.nix"

    ./spec.nix
    ./impermanence.nix
    ./persistence.nix
  ];
}
