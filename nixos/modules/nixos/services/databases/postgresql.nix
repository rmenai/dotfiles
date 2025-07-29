{ config, lib, ... }: {
  options.features.services.databases.postgresql = {
    enable = lib.mkEnableOption "Postgres database";
  };

  config = lib.mkIf config.features.services.databases.postgresql.enable {
    services.postgresql = {
      enable = true;

      authentication = ''
        # Local connections
        local all all trust
        host all all 127.0.0.1/32 trust
        host all all ::1/128 trust
        host all all 10.88.0.0/16 md5

        # For Podman containers (if using bridge network)
        host all all 10.88.0.0/16 trust
      '';

      settings = {
        listen_addresses = lib.mkForce "0.0.0.0,10.88.0.1";
        port = 5432;
      };
    };

    features.persist = {
      directories = { "/var/lib/postgresql" = lib.mkDefault true; };
    };
  };
}
