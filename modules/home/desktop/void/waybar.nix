{ config, ... }:
let
  mkLink = config.dotfiles.mkLink;
in
{
  programs.waybar = {
    systemd.enable = true;
  };

  xdg.configFile."waybar".source = mkLink ./mechabar;
}
