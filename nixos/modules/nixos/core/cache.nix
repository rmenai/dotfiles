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
        "https://nix-community.cachix.org"
        "https://cuda-maintainers.cachix.org"
        "https://cache.nixos.org/"
        "https://wezterm.cachix.org"
      ];

      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
        "wezterm.cachix.org-1:kAbhjYUC9qvblTE+s7S+kl5XM1zVa4skO+E/1IDWdH0="
      ];
    };
  };
}
