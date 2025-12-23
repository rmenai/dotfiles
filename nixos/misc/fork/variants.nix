{ lib, ... }:
{
  virtualisation.vmVariant = {
    features = {
      hardware.disko.profile = lib.mkForce "none";

      impermanence.enable = lib.mkForce false;
      hibernation.enable = lib.mkForce false;
    };

    systemd.network.enable = lib.mkForce false;

    networking = {
      useNetworkd = lib.mkForce false;
      dhcpcd.enable = lib.mkForce true;
      usePredictableInterfaceNames = lib.mkForce true;
    };

    virtualisation = {
      diskSize = 60 * 1024;
      memorySize = 8192;
      cores = 4;
      graphics = true;

      mountHostNixStore = true;

      sharedDirectories = {
        sops-key = {
          source = "/var/lib/sops";
          target = "/var/lib/sops";
          securityModel = "passthrough";
        };
      };

      qemu = {
        options = [
          "-enable-kvm" # Enable KVM acceleration
          "-cpu host" # Use host CPU features
          "-machine type=q35" # Use modern machine type
          "-device virtio-vga-gl" # Better graphics performance
          "-display gtk,gl=on" # Hardware-accelerated display
        ];
      };
    };
  };
}
