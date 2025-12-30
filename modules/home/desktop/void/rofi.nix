{ config, lib, ... }:
let
  cfg = config.features.desktop.void;
in
{
  config = lib.mkIf cfg.enable {
    catppuccin.rofi.enable = true;

    xdg.configFile."networkmanager-dmenu/config.ini".text = ''
      [dmenu]
      dmenu_command = rofi -dmenu -i
      active_chars = ==
      highlight = True
      highlight_fg =
      highlight_bg =
      highlight_bold = True
      compact = False
      pinentry =
      wifi_icons = 󰤯󰤟󰤢󰤥󰤨
      format = {name:<{max_len_name}s}  {sec:<{max_len_sec}s} {icon:>4}
      list_saved = False
      prompt = Networks

      [dmenu_passphrase]
      obscure = False
      obscure_color = #222222

      [pinentry]
      description = Get network password
      prompt = Password:

      [editor]
      terminal = foot
      gui_if_available = True
      gui = nm-connection-editor

      [nmdm]
      rescan_delay = 5
    '';
  };
}
