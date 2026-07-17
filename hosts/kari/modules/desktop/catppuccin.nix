{ lib, pkgs, ... }:
{
  catppuccin = {
    enable = true;

    flavor = "mocha";
    accent = "pink";

    tty.enable = lib.mkForce false;

    sddm = {
      font = "FiraCode Nerd Font";
      fontSize = "24";
    };
  };

  # This is necessary for home-manager to set system wide dark mode.
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };
}
