{ config, lib, ... }: {
  options.features.apps.tools.eza = {
    enable = lib.mkEnableOption "Eza file listing tool";
  };

  config = lib.mkIf config.features.apps.tools.eza.enable {
    programs.eza = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
  };
}
