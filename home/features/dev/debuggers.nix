{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.dev.debuggers;
in {
  options.features.dev.debuggers.enable = mkEnableOption "Install debuggers";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      python312Packages.debugpy
      lldb_19
    ];
  };
}
