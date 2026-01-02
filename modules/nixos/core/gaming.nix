{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.core.gaming;
in
{
  options.features.core.gaming.enable = lib.mkEnableOption "Steam";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      wineWowPackages.waylandFull
      game-devices-udev-rules
      dualsensectl
      bottles
    ];

    programs = {
      gamemode.enable = true;
      gamescope.enable = true;

      steam = {
        enable = true;
        gamescopeSession.enable = true;

        extraCompatPackages = with pkgs; [
          proton-ge-bin
        ];
      };
    };

    # Make ps5 controller work
    hardware.steam-hardware.enable = true;
    boot.kernelModules = [ "hid-playstation" ];
    services.udev.packages = [ pkgs.game-devices-udev-rules ];

    # Work around for issue with capSysNice not working in gamescope
    services.ananicy = {
      enable = true;
      package = pkgs.ananicy-cpp;
      rulesProvider = pkgs.ananicy-cpp;
      extraRules = [
        {
          "name" = "gamescope";
          "nice" = -20;
        }
      ];
    };
  };
}
