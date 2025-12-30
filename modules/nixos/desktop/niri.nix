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
    environment.systemPackages = [ pkgs.xwayland-satellite ];
    security.polkit.enable = true;

    services = {
      xserver.xkb.layout = "us";
      libinput.enable = true;

      # Ensure keyring works properly
      gnome.gnome-keyring.enable = true;
      dbus.enable = true;
    };

    security.pam.services.sddm.enableGnomeKeyring = true;
    programs.ssh.startAgent = lib.mkForce false;
  };
}
