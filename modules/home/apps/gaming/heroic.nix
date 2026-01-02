{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.gaming.heroic;
in
{
  options.features.apps.gaming.heroic = {
    enable = lib.mkEnableOption "Heroic";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      (heroic.override {
        extraPkgs = pkgs: [
          pkgs.gamescope
          pkgs.gamemode
        ];
      })
    ];
  };
}
