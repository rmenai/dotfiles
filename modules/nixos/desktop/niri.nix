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
    };

    programs.ssh.startAgent = lib.mkForce false;
  };
}
