{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.desktop.void;
in
{
  config = lib.mkIf cfg.enable {
    catppuccin.swaylock.enable = true;

    programs.swaylock = {
      package = pkgs.swaylock-effects;

      settings = {
        daemonize = true;
        show-failed-attempts = true;
        ignore-empty-password = true;
        grace-no-touch = true;
        grace = 0;

        screenshots = true;
        effect-blur = "15x15";
        effect-vignette = "1:1";

        clock = true;
        indicator = true;
        indicator-radius = 160;
        indicator-thickness = 20;

        font = "Iosevka Nerd Font Mono";
        datestr = "%a, %B %e";

        ring-color = lib.mkForce "b4befe"; # #b4befe
        inside-color = lib.mkForce "1e1e2e80"; # #1e1e2e
        key-hl-color = lib.mkForce "11111b80"; # #11111b
        text-caps-lock-color = lib.mkForce "b4befe"; # #b4befe

        ring-wrong-color = lib.mkForce "f38ba8"; # #f38ba8
        text-wrong-color = lib.mkForce "f38ba8"; # #f38ba8

        ring-ver-color = lib.mkForce "cba6f7"; # #cba6f7
        text-ver-color = lib.mkForce "cba6f7"; # #cba6f7

        ring-clear-color = lib.mkForce "f2cdcd"; # #f2cdcd
        text-clear-color = lib.mkForce "f2cdcd"; # #f2cdcd
        bs-hl-color = lib.mkForce "f2cdcd"; # #f2cdcd
      };
    };
  };
}
