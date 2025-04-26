{
  inputs,
  lib,
  pkgs,
  ...
}: let
in {
  imports = lib.flatten [
    inputs.hardware.nixosModules.lenovo-yoga-7-14IAH7-hybrid
    inputs.disko.nixosModules.disko
    inputs.impermanence.nixosModules.impermanence
    inputs.lanzaboote.nixosModules.lanzaboote

    ./hardware-configuration.nix

    # Disk config
    ../common/disks/btrfs-luks-impermanence.nix
    ../common/disks/impermanence.nix
    ../common/disks/secure-boot.nix
    ../common/disks/tpm.nix

    # Host config
    ../common/core

    ../common/optional/hyprland.nix
    ../common/optional/podman.nix

    ../common/optional/services/printing.nix
    ../common/optional/services/bluetooth.nix
    ../common/optional/services/openssh.nix
    ../common/optional/services/tlp.nix
    ../common/optional/services/acpid.nix
    ../common/optional/services/tailscale.nix

    ../common/optional/containers

    # User config
    ../common/users/primary.nix
  ];

  hostSpec = {
    hostName = "null";
  };

  boot.supportedFilesystems = ["ntfs" "btrfs"];
  system.stateVersion = "24.11";

  hardware.graphics = {
    enable = true;
  };

  environment = {
    systemPackages = with pkgs; [
      any-nix-shell
      ep
    ];
  };
}
