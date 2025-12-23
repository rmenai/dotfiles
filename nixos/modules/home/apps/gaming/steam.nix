{ lib, config, ... }:
{
  options.features.apps.gaming.steam = {
    enable = lib.mkEnableOption "Steam gaming platform";
  };

  config = lib.mkIf config.features.apps.gaming.steam.enable {
    features.persist = {
      directories = {
        ".steam" = lib.mkDefault true;
      };
    };
  };
}
