{ config, lib, ... }:
let
  cfg = config.features.desktop.void;
in
{
  config = lib.mkIf cfg.enable {
    catppuccin.swaync = {
      enable = true;
      font = "Ubuntu Nerd Font";
    };

    services.swaync = {
      settings = {
        timeout = 5;
        timeout-low = 3;
        timeout-critical = 0;
        fit-to-screen = true;
        keyboard-shortcuts = true;
        notification-2fa-action = true; # Handy for "Copy 2FA code" buttons

        widgets = [
          "title"
          "dnd"
          "notifications"
        ];
      };
    };
  };
}
