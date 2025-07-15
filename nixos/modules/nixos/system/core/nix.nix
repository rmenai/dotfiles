{ config, lib, inputs, outputs, ... }: {
  options.features.system.nix = {
    enable = lib.mkEnableOption "nix configuration";

    gc = {
      enable = lib.mkEnableOption "automatic garbage collection" // {
        default = true;
      };
    };
  };

  config = lib.mkIf config.features.system.nix.enable {
    nixpkgs = {
      overlays = [ outputs.overlays.default ];
      config.allowUnfree = true;
    };

    nix = {
      registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
      nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}")
        config.nix.registry;

      settings = {
        connect-timeout = 5;
        min-free = 128000000; # 128MB
        max-free = 1000000000; # 1GB

        trusted-users = [ "root" config.spec.user ];
        auto-optimise-store = true;
        warn-dirty = false;

        allow-import-from-derivation = true;

        substituters = [
          "https://nix-community.cachix.org"
          "https://cuda-maintainers.cachix.org"
          "https://cache.nixos.org/"
        ];

        trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
        ];

        experimental-features = [ "nix-command" "flakes" ];
      };

      gc = lib.mkIf config.features.system.nix.gc.enable {
        automatic = true;
        randomizedDelaySec = "14m";
        options = "--delete-older-than 10d";
      };

      optimise.automatic = true;
    };
  };
}
