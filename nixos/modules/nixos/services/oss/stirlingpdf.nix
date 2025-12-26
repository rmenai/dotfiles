{ config, lib, ... }:
let
  cfg = config.features.services.stirlingpdf;
in
{
  options.features.services.stirlingpdf = {
    enable = lib.mkEnableOption "Stirling PDF";
  };

  config = lib.mkIf cfg.enable {
    services.stirling-pdf = {
      enable = true;
      environment = {
        SERVER_PORT = 8082;
      };
    };
  };
}
