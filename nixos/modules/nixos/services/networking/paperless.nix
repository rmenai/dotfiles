{ config, lib, ... }:
{
  options.features.services.networking.paperless = {
    enable = lib.mkEnableOption "Paperless";
  };

  config = lib.mkIf config.features.services.networking.paperless.enable {
    sops.secrets."secrets/paperless" = { };

    services.paperless = {
      enable = true;
      dataDir = "/var/lib/paperless";
      consumptionDirIsPublic = true;
      address = "0.0.0.0";
      port = 28981;
      environmentFile = config.sops.secrets."secrets/paperless".path;
    };

    features.persist = {
      directories = {
        "/var/lib/paperless" = lib.mkDefault true;
      };
    };
  };
}
