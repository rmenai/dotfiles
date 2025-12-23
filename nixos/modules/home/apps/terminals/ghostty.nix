{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.features.apps.terminals.ghostty = {
    enable = lib.mkEnableOption "Ghostty terminal emulator";
  };

  config = lib.mkIf config.features.apps.terminals.ghostty.enable {
    home.packages = with pkgs; [ ghostty ];
  };
}
