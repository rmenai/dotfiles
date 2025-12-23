{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.features.apps.socials.whatsapp = {
    enable = lib.mkEnableOption "WhatsApp for Linux";
  };

  config = lib.mkIf config.features.apps.socials.whatsapp.enable {
    home.packages = with pkgs; [ wasistlos ];
  };
}
