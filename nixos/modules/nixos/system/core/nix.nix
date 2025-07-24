{ config, lib, pkgs, inputs, outputs, ... }: {
  options.features.system.nix = {
    enable = lib.mkEnableOption "nix configuration";
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

      optimise.automatic = true;
    };

    programs.nh = {
      enable = true;
      package = inputs.nh.packages.${pkgs.system}.default;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 16";
      flake = "/home/${config.spec.user}/.dotfiles/nixos";
    };
  };
}
