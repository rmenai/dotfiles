{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.tools.git;
in
{
  options.features.apps.tools.git = {
    enable = lib.mkEnableOption "Git tools";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.git ];

    features.core.dotfiles.links.git = "git";
  };
}
