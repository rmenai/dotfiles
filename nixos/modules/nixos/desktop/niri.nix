{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.desktop.niri;
in
{
  options.features.desktop.niri = {
    enable = lib.mkEnableOption "niri";
  };

  config = lib.mkIf cfg.enable {
    programs.niri.enable = true;

    environment.systemPackages = with pkgs; [
      xwayland-satellite
    ];

    services = {
      xserver = {
        enable = true;
        xkb.layout = "us";
      };

      libinput.enable = true;
    };

    xdg.portal = {
      enable = true;

      extraPortals = with pkgs; [
        xdg-desktop-portal-gnome
        xdg-desktop-portal-gtk
      ];
    };

    security.polkit.enable = true;
    services.gnome.gnome-keyring.enable = true;
    security.pam.services.login.enableGnomeKeyring = true;

    programs.ssh.startAgent = lib.mkForce false;
  };
}
