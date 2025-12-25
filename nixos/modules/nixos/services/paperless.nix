{ config, lib, ... }:
let
  cfg = config.features.services.paperless;
in
{
  options.features.services.paperless = {
    enable = lib.mkEnableOption "Paperless";
  };

  config = lib.mkIf cfg.enable {
    sops.secrets."secrets/paperless" = { };

    services.paperless = {
      enable = true;
      dataDir = "/var/lib/paperless";
      consumptionDirIsPublic = true;
      address = "0.0.0.0";
      port = 28981;
      environmentFile = config.sops.secrets."secrets/paperless".path;
    };
  };
}
