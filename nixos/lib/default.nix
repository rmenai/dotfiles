{ lib, ... }:
let
  hosts = import ./hosts.nix { inherit lib; };
  nixos = import ./nixos.nix { inherit lib; };
  home = import ./home.nix { inherit lib; };
  colmena = import ./colmena.nix { inherit lib; };
  utils = import ./utils.nix { inherit lib; };
in {
  inherit (utils) relativeToRoot scanPaths;
  inherit (hosts) discoverHosts;
  inherit (nixos) mkNixosConfigurations;
  inherit (home) mkHomeConfigurations;
  inherit (colmena) mkColmenaConfig;
}
