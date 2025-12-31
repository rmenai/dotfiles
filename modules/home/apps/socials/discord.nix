{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.socials.discord;
in
{
  options.features.apps.socials.discord = {
    enable = lib.mkEnableOption "Discord chat application";
  };

  config = lib.mkIf cfg.enable {
    # TODO: use home-manager module for vesktop
    home.packages = [ pkgs.vesktop ];
    catppuccin.vesktop.enable = true;
  };
}
