{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.terminals.kitty;
in
{
  options.features.apps.terminals.kitty = {
    enable = lib.mkEnableOption "Kitty terminal emulator";
  };

  config = lib.mkIf cfg.enable {
    programs.kitty = {
      enable = true;

      font = {
        name = "Iosevka Nerd Font Mono";
        size = 12;
      };

      keybindings = {
        "ctrl+equal" = "change_font_size all +2.0";
        "ctrl+minus" = "change_font_size all -2.0";
        "ctrl+0" = "change_font_size all 0";
      };

      settings = {
        shell = "${pkgs.nushell}/bin/nu";
        editor = "nvim";

        input_delay = 0;
        repaint_delay = 2;
        sync_to_monitor = "no";
        wayland_enable_ime = "no";

        background_opacity = "0.9";
      };
    };

    catppuccin.kitty.enable = true;
  };
}
