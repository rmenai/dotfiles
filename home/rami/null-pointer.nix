{ config, ... }:
{
  imports = [
    ./home.nix
    ./impermanence.nix
    ../common
  ];
}
