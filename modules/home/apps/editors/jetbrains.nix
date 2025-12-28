{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.editors.jetbrains;
in
{
  options.features.apps.editors.jetbrains = {
    enable = lib.mkEnableOption "JetBrains IDEs";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.jetbrains-toolbox ];
  };
}
