{
  inputs,
  lib,
  pkgs,
  config,
  ...
}: let
in {
  imports = lib.flatten [
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
    ../common/optional/games.nix
    ../common/optional/podman.nix
    ../common/optional/vm.nix
    ../common/optional/obs.nix
    ../common/optional/adb.nix

    # ../common/optional/services/acpid.nix
    # ../common/optional/services/tailscale.nix
    ../common/optional/services/display.nix
    ../common/optional/services/input.nix
    ../common/optional/services/bluetooth.nix
    ../common/optional/services/printing.nix
    ../common/optional/services/openssh.nix
    ../common/optional/services/sound.nix
    ../common/optional/services/tlp.nix

    # ../common/optional/containers
    # ../common/apps/hotspot.nix

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

  hardware.enableAllFirmware = true;

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.latest;
    modesetting.enable = true;
    powerManagement.finegrained = true;
    nvidiaSettings = true;
    open = true;

    # Info: <https://wiki.nixos.org/wiki/NVIDIA#Common_setup>
    prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";

      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
    };

    # Info: <https://download.nvidia.com/XFree86/Linux-x86_64/460.73.01/README/dynamicpowermanagement.html>
    powerManagement.enable = true;
  };

  services.fstrim.enable = true;
  hardware.cpu.intel.updateMicrocode = true;

  networking.useNetworkd = true;
  systemd.network.enable = true;

  systemd.network.networks."10-wlp0s20f3" = {
    matchConfig.Name = "wlp0s20f3";
    networkConfig.DHCP = "yes";
  };

  networking.extraHosts = ''
    10.10.10.10 kali
    10.10.10.8  flare
  '';

  environment = {
    systemPackages = with pkgs; [
      ep
    ];
  };

  # GPU passthrough and virtualization
  # boot.kernelParams = ["intel_iommu=on" "iommu=pt" "vfio-pci.ids=10de:28e0,10de:22be"];
  # boot.initrd.kernelModules = ["vfio-pci" "vfio" "vfio_iommu_type1"];
  # boot.kernelModules = ["vfio-pci"];
  # boot.blacklistedKernelModules = ["nouveau"];
}
