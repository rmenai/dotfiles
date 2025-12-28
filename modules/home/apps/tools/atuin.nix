{ config, lib, ... }:
let
  cfg = config.features.apps.tools.atuin;
in
{
  options.features.apps.tools.atuin = {
    enable = lib.mkEnableOption "Atuin shell history";
  };

  config = lib.mkIf cfg.enable {
    programs.atuin = {
      enable = true;

      settings = {
        auto_sync = true;
        sync_frequency = "1h";
        style = "compact";
        inline_height = 20;
        enter_accept = true;
      };
    };

    catppuccin.atuin.enable = true;
  };
}
