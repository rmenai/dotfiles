{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.features.apps.browsers.brave = {
    enable = lib.mkEnableOption "Brave browser";
  };

  config = lib.mkIf config.features.apps.browsers.brave.enable {
    home.packages = with pkgs; [ brave ];
  };
}
