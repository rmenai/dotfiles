{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.features.apps.development.helix = {
    enable = lib.mkEnableOption "Helix text editor";
  };

  config = lib.mkIf config.features.apps.development.helix.enable {
    home.packages = with pkgs; [ helix ];
  };
}
