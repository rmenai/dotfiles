{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.socials.whatsapp;
in
{
  options.features.apps.socials.whatsapp = {
    enable = lib.mkEnableOption "WhatsApp for Linux";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.wasistlos ];
  };
}
