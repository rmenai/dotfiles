{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.desktop.waybar;
in
{
  options.features.desktop.waybar = {
    enable = lib.mkEnableOption "Waybar";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      bluez
      brightnessctl
      networkmanager
      pulseaudio
      fzf
    ];

    xdg.configFile = {
      "waybar/scripts".source = "${inputs.mechabar}/scripts";
      "waybar/styles".source = "${inputs.mechabar}/styles";
      "waybar/themes".source = "${inputs.mechabar}/themes";
      "waybar/modules".source = "${inputs.mechabar}/modules";
    };

    programs.waybar = {
      enable = true;

      style = ''
        /* ignore GTK theme */
        * {
            all: initial;
        }

        @import "themes/catppuccin-mocha.css";
        @import "styles/fonts.css";
        @import "styles/global.css";
        @import "styles/modules-center.css";
        @import "styles/modules-left.css";
        @import "styles/modules-right.css";
        @import "styles/states.css";
      '';

      settings = {
        mainBar = {
          layer = "top";
          height = 0;
          width = 0;
          margin = "0";
          spacing = 0;
          mode = "dock";
          reload_style_on_change = true;

          "include" = [
            # modules-left
            "~/.config/waybar/modules/custom/user.jsonc"

            # modules-center
            "~/.config/waybar/modules/temperature.jsonc"
            "~/.config/waybar/modules/memory.jsonc"
            "~/.config/waybar/modules/cpu.jsonc"
            "~/.config/waybar/modules/custom/distro.jsonc"
            "~/.config/waybar/modules/idle_inhibitor.jsonc"
            "~/.config/waybar/modules/clock.jsonc"
            "~/.config/waybar/modules/network.jsonc"
            "~/.config/waybar/modules/bluetooth.jsonc"
            "~/.config/waybar/modules/custom/system_update.jsonc"

            # modules-right
            "~/.config/waybar/modules/mpris.jsonc"
            "~/.config/waybar/modules/pulseaudio.jsonc"
            "~/.config/waybar/modules/backlight.jsonc"
            "~/.config/waybar/modules/battery.jsonc"
            "~/.config/waybar/modules/custom/power_menu.jsonc"

            "~/.config/waybar/modules/custom/dividers.jsonc"
          ];

          modules-left = [
            "group/user"
            "custom/left_div#1"
            "niri/workspaces"
            "custom/right_div#1"
          ];

          modules-center = [
            "custom/spacer"
            "custom/left_div#2"
            "temperature"
            "custom/left_div#3"
            "memory"
            "custom/left_div#4"
            "cpu"
            "custom/left_inv#1"
            "custom/left_div#5"
            "custom/distro"
            "custom/right_div#2"
            "custom/right_inv#1"
            "idle_inhibitor"
            "clock#time"
            "custom/right_div#3"
            "clock#date"
            "custom/right_div#4"
            "network"
            "bluetooth"
            "custom/system_update"
            "custom/right_div#5"
          ];

          modules-right = [
            "mpris"
            "custom/left_div#6"
            "group/pulseaudio"
            "custom/left_div#7"
            "backlight"
            "custom/left_div#8"
            "battery"
            "custom/left_inv#2"
            "custom/power_menu"
          ];

          "custom/spacer" = {
            format = "    ";
            tooltip = false;
          };

          "custom/distro" = {
            format = "";
            tooltip = false;
          };
        };
      };
    };

    catppuccin.waybar.enable = lib.mkForce false;
  };
}
