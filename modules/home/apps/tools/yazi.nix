{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.tools.yazi;
in
{
  options.features.apps.tools.yazi = {
    enable = lib.mkEnableOption "Yazi file manager";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      p7zip
      poppler
      jq
      fd
    ];

    programs.yazi = {
      enable = true;
      enableNushellIntegration = true;
      shellWrapperName = "y";
    };

    catppuccin.yazi.enable = true;
  };
}
