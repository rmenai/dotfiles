{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.dev.godot;
in
{
  options.features.apps.dev.godot = {
    enable = lib.mkEnableOption "Godot Game Engine";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.godot ];
  };
}
