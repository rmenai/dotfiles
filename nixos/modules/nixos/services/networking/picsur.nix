{ config, lib, ... }: {
  options.features.services.networking.picsur = {
    enable = lib.mkEnableOption "Image sharing";
  };

  config = lib.mkIf config.features.services.networking.picsur.enable {
    sops.secrets."secrets/picsur" = { };

    virtualisation.oci-containers.containers."picsur" = {
      image = "ghcr.io/caramelfur/picsur:latest";
      ports = [ "127.0.0.1:8070:8080" ];
      environmentFiles = [ config.sops.secrets."secrets/picsur".path ];
      environment = {
        PICSUR_DB_HOST = "host.docker.internal";
        PICSUR_DB_PORT = "5432";
        PICSUR_DB_DATABASE = "picsur";
        PICSUR_DB_USERNAME = "picsur";
        PICSUR_DB_PASSWORD = "picsur";
      };
    };

    services.postgresql = {
      ensureDatabases = [ "picsur" ];
      ensureUsers = [{
        name = "picsur";
        ensureDBOwnership = true;
      }];
    };
  };
}
