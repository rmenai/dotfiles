{ lib, ... }: {
  virtualisation.vmVariant = {
    spec.host = lib.mkForce "vm";

    features = {
      hardware.disko.profile = lib.mkForce "none";

      impermanence.enable = lib.mkForce false;
      hibernation.enable = lib.mkForce false;
    };

    virtualisation = {
      diskSize = 60 * 1024;
      memorySize = 8192;
      cores = 4;
      graphics = true;

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
