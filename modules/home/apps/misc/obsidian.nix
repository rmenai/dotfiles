{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.misc.obsidian;
in
{
  options.features.apps.misc.obsidian = {
    enable = lib.mkEnableOption "Obsidian note-taking app";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.obsidian ];

    xdg.mimeApps.defaultApplications = {
      "x-scheme-handler/obsidian" = "obsidian.desktop";
    };
  };
}
