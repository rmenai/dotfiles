{ lib, config, ... }: {
  options.features.apps.tools.zoxide = {
    enable = lib.mkEnableOption "Zoxide directory jumper";
  };

  config = lib.mkIf config.features.apps.tools.zoxide.enable {
    programs.zoxide = {
      enable = true;
      enableBashIntegration = true;
    };
  };
}
