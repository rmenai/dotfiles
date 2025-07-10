{
  inputs,
  lib,
  pkgs,
  ...
}: let
in {
  imports = lib.flatten [
    inputs.disko.nixosModules.disko
    inputs.impermanence.nixosModules.impermanence
    inputs.lanzaboote.nixosModules.lanzaboote

    ./hardware-configuration.nix

    # Disk config
    # ../common/disks/btrfs-luks-impermanence.nix
    # ../common/disks/impermanence.nix
    # ../common/disks/hibernation.nix
    # ../common/disks/tpm.nix

    # Host config
    ../common/core

    # ../common/optional/hyprland.nix
    # ../common/optional/fonts.nix
    # ../common/optional/oxidise.nix
    # ../common/optional/games.nix
    # ../common/optional/podman.nix
    # ../common/optional/vm.nix
    # ../common/optional/obs.nix
    # ../common/optional/adb.nix

    # ../common/optional/services/acpid.nix
    # ../common/optional/services/tailscale.nix
    # ../common/optional/services/display.nix
    # ../common/optional/services/input.nix
    # ../common/optional/services/bluetooth.nix
    # ../common/optional/services/printing.nix
    # ../common/optional/services/openssh.nix
    # ../common/optional/services/sound.nix
    # ../common/optional/services/tlp.nix

    # ../common/optional/containers
    # ../common/apps/hotspot.nix

    # User config
    # ../common/users/vm.nix
  ];

  spec = {
    hostName = "null";
  };

  boot.supportedFilesystems = ["ntfs" "btrfs"];
  system.stateVersion = "24.11";

  users.users.alice = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    initialPassword = "test";
  };

  # hardware.enableAllFirmware = true;
  # services.fstrim.enable = true;
  # hardware.cpu.intel.updateMicrocode = true;
  #
  # networking.useNetworkd = true;
  # systemd.network.enable = true;

  # systemd.network.networks."10-wlp0s20f3" = {
  #   matchConfig.Name = "wlp0s20f3";
  #   networkConfig.DHCP = "yes";
  # };
  #
  # networking.extraHosts = ''
  #   10.10.10.10 kali
  #   10.10.10.8  flare
  # '';
  #
  # networking.firewall.allowedTCPPorts = [8080];

  # environment = {
  #   systemPackages = with pkgs; [
  #     ep
  #   ];
  # };
}
