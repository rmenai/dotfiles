{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.dev.nix;
in
{
  options.features.apps.dev.nix = {
    enable = lib.mkEnableOption "Nix language tools";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      nixfmt-rfc-style
      statix
    ];
  };
}
