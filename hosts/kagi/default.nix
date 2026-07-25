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
    # ./modules/system/syncthing.nix
    # ./modules/system/tailscale.nix
  ];
}
