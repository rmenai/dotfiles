{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.features.system.xdg = {
    enable = lib.mkEnableOption "XDG desktop portal configuration";
  };

  config = lib.mkIf config.features.system.xdg.enable {
    xdg.portal.enable = true;
    xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
}
