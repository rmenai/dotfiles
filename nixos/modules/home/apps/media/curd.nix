{ config, lib, ... }:
let
  cfg = config.features.apps.media.curd;
in
{
  options.features.apps.media.curd = {
    enable = lib.mkEnableOption "Curd CLI";
  };

  config = lib.mkIf cfg.enable {
    # home.packages = [
    #   inputs.curd.packages.${pkgs.stdenv.hostPlatform.system}.default
    # ];

    features.core.dotfiles.links.curd = "curd";
  };
}
