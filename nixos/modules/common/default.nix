{ lib, ... }: {
  imports = [ ./spec.nix ./impermanence.nix ./persistence.nix ]
    ++ lib.optionals (builtins.getEnv "COLMENA_BUILD" != "1")
    [ ./deployment.nix ];
}
