{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.editors.vscode;
in
{
  options.features.apps.editors.vscode = {
    enable = lib.mkEnableOption "VsCode";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.vscode ];
    # catppuccin.vscode.enable = true;
  };
}
