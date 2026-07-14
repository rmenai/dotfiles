{
  config,
  lib,
  pkgs,
  ...
}:
{
  nix = {
    package = lib.mkDefault pkgs.nix;

    settings = {
      connect-timeout = 5;
      min-free = 128000000; # 128MB
      max-free = 1000000000; # 1GB

      trusted-users = [
        "root"
        config.home.username
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
}
