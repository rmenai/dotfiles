{ config, lib, ... }: {
  virtualisation.vmVariant = {
    features = {
      hardware.disko.profile = lib.mkForce "none";

      impermanence.enable = lib.mkForce false;
      hibernation.enable = lib.mkForce false;

      display.sddm.enable = lib.mkForce false;
      display.xserver.enable = lib.mkForce false;
      display.hyprland.enable = lib.mkForce false;
    };

    home-manager.users.${config.spec.user} = {
      features = {
        impermanence.enable = lib.mkForce false;
        persist.enable = lib.mkForce false;
      };
    };

    users.users.${config.spec.user}.initialPassword = "test";

    virtualisation = {
      diskSize = 65536;
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
