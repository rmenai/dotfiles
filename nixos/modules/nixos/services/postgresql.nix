{ config, lib, ... }:
let
  cfg = config.features.services.postgresql;
in
{
  options.features.services.postgresql = {
    enable = lib.mkEnableOption "Postgres database";
  };

  config = lib.mkIf cfg.enable {
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
  };
}
