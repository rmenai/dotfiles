{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.services.vaultwarden;
in
{
  options.features.services.vaultwarden = {
    enable = lib.mkEnableOption "Vaultwarden";
  };

  config = lib.mkIf cfg.enable {
    sops.secrets."secrets/vaultwarden" = { };

    environment.systemPackages = [ pkgs.vaultwarden ];

    services.vaultwarden = {
      enable = true;
      dbBackend = "sqlite";
      backupDir = "/var/backup/vaultwarden";
      environmentFile = config.sops.secrets."secrets/vaultwarden".path;
      config = {
        ROCKET_ADDRESS = "127.0.0.1";
        ROCKET_PORT = 8222;
        LOG_FILE = "/var/lib/vaultwarden/access.log";
      };
    };
  };
}
