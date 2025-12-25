{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.tools.btop;
in
{
  options.features.apps.tools.btop = {
    enable = lib.mkEnableOption "System Monitoring (btop, bottom)";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      btop
      bottom
      bandwhich
    ];

    features.core.dotfiles.links.btop = "btop";
  };
}
