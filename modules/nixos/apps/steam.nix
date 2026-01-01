{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.steam;
in
{
  options.features.apps.steam.enable = lib.mkEnableOption "Steam";

  config = lib.mkIf cfg.enable {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    environment.systemPackages = with pkgs; [
      wineWowPackages.waylandFull
      mangohud
    ];

    programs = {
      gamemode.enable = true;

      gamescope = {
        enable = true;
        capSysNice = true;
      };

      steam = {
        enable = true;
        gamescopeSession.enable = true;

        extraCompatPackages = with pkgs; [
          proton-ge-bin
        ];
      };
    };
  };
}
