{ config, lib, ... }:
let
  cfg = config.features.desktop.void;
  mkLink = config.features.core.dotfiles.mkLink;
in
{
  config = lib.mkIf cfg.enable {
    programs.waybar = {
      systemd = {
        enable = true;
        target = "graphical-session.target";
      };
    };

    xdg.configFile."waybar".source = mkLink ./mechabar;
  };
}
