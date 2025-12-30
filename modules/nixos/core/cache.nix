{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.core.cache;
in
{
  options.features.core.cache = {
    enable = lib.mkEnableOption "NixOS Caching";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ cachix ];

    nix.settings = {
      substituters = [
        "https://cache.nixos.org/"
        "https://nix-community.cachix.org"
        "http://cache.thalheim.io"
        "https://colmena.cachix.org"
        "https://microvm.cachix.org"
        "https://niri.cachix.org"
        "https://catppuccin.cachix.org"
      ];

      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cache.thalheim.io-1:R7msbosLEZKrxk/lKxf9BTjOOH7Ax3H0Qj0/6wiHOgc="
        "colmena.cachix.org-1:7BzpDnjjH8ki2CT3f6GdOk7QAzPOl+1t3LvTLXqYcSg="
        "microvm.cachix.org-1:oXnBc6hRE3eX5rSYdRyMYXnfzcCxC7yKPTbZXALsqys="
        "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
        "catppuccin.cachix.org-1:noG/4HkbhJb+lUAdKrph6LaozJvAeEEZj4N732IysmU="
      ];
    };
  };
}
