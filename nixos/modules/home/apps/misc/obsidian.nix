{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.features.apps.misc.obsidian = {
    enable = lib.mkEnableOption "Obsidian note-taking app";
  };

  config = lib.mkIf config.features.apps.misc.obsidian.enable {
    home.packages = with pkgs; [
      obsidian
      anki
    ];
  };
}
