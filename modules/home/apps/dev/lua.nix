{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.dev.lua;
in
{
  options.features.apps.dev.lua = {
    enable = lib.mkEnableOption "Lua development tools";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      luajit
      stylua
    ];
  };
}
