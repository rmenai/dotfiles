{ config, lib, ... }:
{
  options.features.services.networking.stirlingpdf = {
    enable = lib.mkEnableOption "Stirling PDF";
  };

  config = lib.mkIf config.features.services.networking.stirlingpdf.enable {
    services.stirling-pdf = {
      enable = true;
      environment = {
        SERVER_PORT = 8082;
      };
    };

    features.persist = {
      directories = {
        "/var/lib/stirling-pdf" = lib.mkDefault true;
      };
    };
  };
}
