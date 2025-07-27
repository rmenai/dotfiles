{ config, lib, ... }: {
  options.features.services.monitoring.uptime-kuma = {
    enable = lib.mkEnableOption "Uptime Kuma configuration";
  };

  config = lib.mkIf config.features.services.monitoring.uptime-kuma.enable {
    services.uptime-kuma = {
      enable = true;
      appriseSupport = true;

      settings = {
        PORT = "3001";
        HOST = "0.0.0.0";
        DATA_DIR = "/var/lib/uptime-kuma/";
      };
    };

    features.persist = { directories = { "/var/lib/uptime-kuma" = true; }; };
  };
}
