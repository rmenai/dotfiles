{ config, lib, ... }:
let
  cfg = config.features.services.shlink;
in
{
  options.features.services.shlink = {
    enable = lib.mkEnableOption "Shlink url shortener";
  };

  config = lib.mkIf cfg.enable {
    virtualisation.oci-containers.containers."shlink" = {
      image = "shlinkio/shlink:stable";
      ports = [ "127.0.0.1:8385:8385" ];
      environment = {
        PORT = "8385";

        DB_DRIVER = "postgres";
        DB_HOST = "host.docker.internal";
        DB_PORT = "5432";
        DB_NAME = "shlink";
        DB_USER = "shlink";
        DB_PASSWORD = "shlink";
      };
    };

    virtualisation.oci-containers.containers."shlink-web" = {
      image = "shlinkio/shlink-web-client";
      ports = [ "127.0.0.1:8386:8080" ];
    };

    services.postgresql = {
      ensureDatabases = [ "shlink" ];
      ensureUsers = [
        {
          name = "shlink";
          ensureDBOwnership = true;
        }
      ];
    };
  };
}
