{
  imports = [
    ./core.nix
    ./filesystem.nix
    ./networking.nix
    ./generated.nix
    ./hardware.nix
    ./scratch.nix
    ./users.nix

    ./variants

    ./modules/hardware/nvidia.nix
    ./../../modules/nixos/hardware/bluetooth.nix
    # ./../../modules/nixos/hardware/lazaboote.nix
    # ./modules/hardware/hibernation.nix
    ./modules/hardware/tlp.nix

    ./modules/system/nix.nix
    ./modules/system/cache.nix
    ./../../modules/nixos/system/diff.nix
    ./../../modules/nixos/system/nix-ld.nix

    ./../../modules/nixos/system/printing.nix
    # ./modules/system/gaming.nix
    ./modules/system/audio.nix
    ./modules/system/ssh.nix

    # ./modules/system/libvirt.nix
    # ./../../modules/nixos/system/virtualbox.nix
    # ./modules/system/syncthing.nix
    # ./modules/system/tailscale.nix

    # ./modules/apps/obs.nix
    ./../../modules/nixos/apps/adb.nix

    ./modules/desktop/catppuccin.nix
    ./modules/desktop/fcitx5.nix
    ./modules/desktop/fonts.nix
    ./modules/desktop/niri.nix
    ./modules/desktop/sddm.nix
  ];
}
