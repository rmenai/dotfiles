{ config, lib, ... }:
let
  cfg = config.features.apps.tools.eza;
in
{
  options.features.apps.tools.eza = {
    enable = lib.mkEnableOption "Eza file listing tool";
  };

  config = lib.mkIf cfg.enable {
    programs.eza = {
      enable = true;
      enableBashIntegration = true;
    };

    catppuccin.eza.enable = true;
  };
}
