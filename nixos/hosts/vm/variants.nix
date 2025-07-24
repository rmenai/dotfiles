{ lib, ... }: {
  virtualisation.vmVariant = {
    features = { hardware.disko.profile = lib.mkForce "none"; };

    virtualisation = {
      diskSize = 60 * 1024;
      memorySize = 8192;
      cores = 4;
      graphics = true;

      mountHostNixStore = true;

      sharedDirectories = {
        sops-key = {
          source = "/var/lib/sops";
          target = "/mnt/var/lib/sops";
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

    systemd.services.setup-sops-key = {
      description = "Copy SOPS key if it does not exist";
      serviceConfig.Type = "oneshot";

      # Ensure sops-nix waits for this to complete
      before = [ "sops-nix.service" ];
      wantedBy = [ "multi-user.target" ];

      script = ''
        echo "Setting up SOPS key for the first time..."
        mkdir -p /var/lib/sops
        cp /mnt/var/lib/sops/key.txt /var/lib/sops/key.txt
      '';
    };
  };
}
