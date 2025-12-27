{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.terminals.foot;
in
{
  options.features.apps.terminals.foot = {
    enable = lib.mkEnableOption "foot";
  };

  config = lib.mkIf cfg.enable {
    programs.foot = {
      enable = true;

      settings = {
        main = {
          font = "Iosevka Nerd Font Mono:size=12";
          shell = "${pkgs.zellij}/bin/zellij";
          pad = "10x10";
        };

        scrollback = {
          lines = 10000;
          multiplier = 3.0;
        };

        colors = {
          alpha = "0.9";
        };

        mouse = {
          hide-when-typing = "yes";
        };
      };
    };

    catppuccin.foot.enable = true;
  };
}
