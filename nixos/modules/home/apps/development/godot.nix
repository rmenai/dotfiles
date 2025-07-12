{ config, lib, pkgs, ... }: {
  options.features.apps.development.godot = {
    enable = lib.mkEnableOption "Godot game engine";
  };

  config = lib.mkIf config.features.apps.development.godot.enable {
    home.packages = with pkgs; [ godot ];
  };
}
