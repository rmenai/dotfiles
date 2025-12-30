{ config, lib, ... }:
let
  cfg = config.features.apps.tools.zoxide;
in
{
  options.features.apps.tools.zoxide = {
    enable = lib.mkEnableOption "Zoxide directory jumper";
  };

  config = lib.mkIf cfg.enable {
    programs.zoxide = {
      enable = true;
      enableNushellIntegration = true;
      options = [ "--cmd cd" ];
    };
  };
}
