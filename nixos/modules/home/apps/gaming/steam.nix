{ lib, config, ... }: {
  options.features.apps.gaming = {
    enable = lib.mkEnableOption "Steam gaming platform";
  };

  config = lib.mkIf config.features.apps.gaming.enable {
    features.persist = { directories = { ".steam" = lib.mkDefault true; }; };
  };
}
