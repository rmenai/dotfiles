{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.profiles.gaming;
in
{
  options.features.profiles.gaming.enable = lib.mkEnableOption "Gaming Persona";

  config = lib.mkIf cfg.enable {
    features = {
      apps.steam.enable = true;
      services.gamemode.enable = true;
    };

    environment.systemPackages = with pkgs; [
      mangohud
      bottles
      heroic
    ];
  };
}
