{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.tools.atuin;
in
{
  options.features.apps.tools.atuin = {
    enable = lib.mkEnableOption "Atuin shell history";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.atuin ];

    features.core.dotfiles.links.atuin = "atuin";
  };
}
