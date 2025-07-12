{ pkgs, lib, config, ... }: {
  options.features.apps.misc.blender = {
    enable = lib.mkEnableOption "Blender 3D modeling software";
  };

  config = lib.mkIf config.features.apps.misc.blender.enable {
    home.packages = with pkgs; [ blender ];
  };
}
