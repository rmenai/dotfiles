{
  inputs,
  lib,
  pkgs,
  config,
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
    ../common/optional/vm.nix

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

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.latest;
    modesetting.enable = true;
    powerManagement.finegrained = true;
    nvidiaSettings = true;
    open = true;
  };

  # GPU passthrough and virtualization
  # boot.kernelParams = ["intel_iommu=on" "iommu=pt" "vfio-pci.ids=10de:28e0,10de:22be"];
  # boot.initrd.kernelModules = ["vfio-pci" "vfio" "vfio_iommu_type1"];
  # boot.kernelModules = ["vfio-pci"];
  # boot.blacklistedKernelModules = ["nouveau"];

  environment = {
    systemPackages = with pkgs; [
      ep
    ];
  };
}
