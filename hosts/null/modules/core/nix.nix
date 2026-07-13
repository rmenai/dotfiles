{
  config,
  inputs,
  lib,
  ...
}:
{
  nix = {
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      connect-timeout = 5;
      min-free = 128000000; # 128MB
      max-free = 1000000000; # 1GB

      trusted-users = [
        "root"
        "vault"
      ];

      auto-optimise-store = true;
      warn-dirty = false;
      allow-import-from-derivation = true;

      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };

    optimise.automatic = true;
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 16";
    flake = "/home/vault/.dotfiles";
  };
}
