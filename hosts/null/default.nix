{
  inputs,
  config,
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

    # Host config
    ../common/core

    ../common/optional/sound.nix
    ../common/optional/podman.nix
    ../common/optional/wayland.nix
    ../common/optional/hyprland.nix
    ../common/optional/sddm.nix

    ../common/optional/services/tlp.nix
    ../common/optional/services/printing.nix

    ../common/optional/containers/echo.nix

    # User config
    ../common/users/primary.nix
  ];

  hostSpec = {
    hostName = "null";
  };

  networking = {
    hostName = config.hostSpec.hostName;
    networkmanager.enable = true;
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    timeout = 3;
  };

  # boot.initrd = {
  #   systemd.enable = true;
  # };

  boot.supportedFilesystems = ["ntfs"];
  system.stateVersion = "24.11";

  environment = {
    systemPackages = with pkgs; [
      any-nix-shell
      ep
    ];
  };

  hardware.graphics = {
    enable = true;
  };

  fonts.packages = with pkgs; [
    (nerdfonts.override {fonts = ["FiraCode" "JetBrainsMono"];})
  ];
}
