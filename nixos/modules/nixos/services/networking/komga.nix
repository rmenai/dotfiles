{ config, lib, ... }:
{
  options.features.services.networking.komga = {
    enable = lib.mkEnableOption "Digital Comis Library";
  };

  config = lib.mkIf config.features.services.networking.komga.enable {
    services.komga = {
      enable = true;
      stateDir = "/var/lib/komga";
      settings.server.port = 10080;
    };

    features.persist = {
      directories = {
        "/var/lib/komga" = lib.mkDefault true;
      };
    };
  };
}
