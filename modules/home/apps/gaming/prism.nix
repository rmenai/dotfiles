{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.gaming.prism;
in
{
  options.features.apps.gaming.prism = {
    enable = lib.mkEnableOption "Prism Minecraft launcher";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.prismlauncher ];
  };
}
