{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.tools.ripgrep;
in
{
  options.features.apps.tools.ripgrep = {
    enable = lib.mkEnableOption "Ripgrep search tools";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      ripgrep
      ripgrep-all
    ];
  };
}
