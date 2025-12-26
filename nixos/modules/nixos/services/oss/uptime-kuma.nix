{ config, lib, ... }:
let
  cfg = config.features.services.uptime-kuma;
in
{
  options.features.services.uptime-kuma = {
    enable = lib.mkEnableOption "Uptime Kuma configuration";
  };

  config = lib.mkIf cfg.enable {
    services.uptime-kuma = {
      enable = true;
      appriseSupport = true;

      settings = {
        PORT = "3001";
        HOST = "0.0.0.0";
        DATA_DIR = "/var/lib/uptime-kuma/";
      };
    };
  };
}
