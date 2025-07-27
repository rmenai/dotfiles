{ config, lib, ... }: {
  options.features.services.networking.adguardhome = {
    enable = lib.mkEnableOption "Adguardhome DNS resolver";
  };

  config = lib.mkIf config.features.services.networking.adguardhome.enable {
    services.adguardhome = {
      enable = true;
      mutableSettings = true;
      host = "0.0.0.0";
      port = 3000;
    };

    features.persist = { directories = { "/var/lib/AdGuardHome" = true; }; };
  };
}
