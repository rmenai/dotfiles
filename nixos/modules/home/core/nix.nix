{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.core.nix;
in
{
  options.features.core.nix = {
    enable = lib.mkEnableOption "Nix Configuration for home-manager";
  };

  config = lib.mkIf cfg.enable {
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

    features.core.dotfiles.links.nixos = "nixos";
  };
}
