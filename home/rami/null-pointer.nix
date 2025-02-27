{ config, ... }:
{
  imports = [
    ../features/cli
    ../features/dev
    ../common
    ./home.nix
    ./impermanence.nix
  ];
}
