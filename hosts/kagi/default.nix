{
  imports = [
    ./core.nix
    ./filesystem.nix
    ./networking.nix
    ./generated.nix
    ./hardware.nix
    ./scratch.nix
    ./users.nix

    ./modules/system/ssh.nix
    ./../../modules/nixos/system/tailscale.nix
    # ./modules/system/syncthing.nix
  ];
}
