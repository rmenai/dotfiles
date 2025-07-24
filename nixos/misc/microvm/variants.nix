{ lib, ... }: {
  microvm = {
    hypervisor = "qemu";
    vcpu = 4;
    mem = 8 * 1024;

    interfaces = [{
      type = "user";
      id = "vm-qemu";
      mac = "02:00:00:00:00:01";
    }];

    writableStoreOverlay = "/nix/.rw-store";

    shares = [{
      tag = "ro-store";
      source = "/nix/store";
      mountPoint = "/nix/.ro-store";
    }
    # {
    #   tag = "sops-key";
    #   source = "/var/lib/sops";
    #   mountPoint = "/var/lib/sops";
    # }
      ];
  };

  nix.optimise.automatic = lib.mkForce false;
  nix.settings.auto-optimise-store = lib.mkForce false;
}
