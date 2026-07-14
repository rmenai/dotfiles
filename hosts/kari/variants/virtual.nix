{ lib, ... }:
{
  virtualisation.vmVariant = {
    disabledModules = [
      ../modules/hardware/hibernation.nix
    ];

    disko.enableConfig = lib.mkForce false;

    home-manager.users.rami = {
      dotfiles.mutable = lib.mkForce false;
    };

    services = {
      btrfs.autoScrub.enable = lib.mkForce false;
      syncthing.enable = lib.mkForce false;

      displayManager.autoLogin = {
        enable = lib.mkForce true;
        user = "rami";
      };
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
