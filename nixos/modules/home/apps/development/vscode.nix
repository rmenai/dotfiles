{ config, lib, pkgs, ... }: {
  options.features.apps.development.vscode = {
    enable = lib.mkEnableOption "VsCode";
  };

  config = lib.mkIf config.features.apps.development.vscode.enable {
    home.packages = [ pkgs.vscode ];
  };
}
