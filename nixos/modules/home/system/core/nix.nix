{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.features.system.nix = {
    enable = lib.mkEnableOption "nix configuration for home-manager";
  };

  config = lib.mkIf config.features.system.nix.enable {
    nixpkgs = {
      config.allowUnfree = true;
    };

    nix = {
      package = lib.mkDefault pkgs.nix;

      settings = {
        connect-timeout = 5;
        min-free = 128000000; # 128MB
        max-free = 1000000000; # 1GB

        trusted-users = [
          "root"
          config.spec.user
        ];
        auto-optimise-store = true;
        warn-dirty = false;

        allow-import-from-derivation = true;
        experimental-features = [
          "nix-command"
          "flakes"
        ];
      };
    };

    features.dotfiles = {
      paths = {
        ".config/nixos" = lib.mkDefault "nixos";
        ".config/nixpkgs" = lib.mkDefault "nixpkgs";
      };
    };
  };
}
