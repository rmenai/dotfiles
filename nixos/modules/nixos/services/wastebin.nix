{ config, lib, ... }:
let
  cfg = config.features.services.wastebin;
in
{
  options.features.services.wastebin = {
    enable = lib.mkEnableOption "Wastebin service";
  };

  config = lib.mkIf cfg.enable {
    sops.secrets."secrets/wastebin" = { };

    services.wastebin = {
      enable = true;
      stateDir = "/var/lib/wastebin";
      secretFile = config.sops.secrets."secrets/wastebin".path;
      settings = {
        WASTEBIN_ADDRESS_PORT = "0.0.0.0:8088";
        WASTEBIN_DATABASE_PATH = "/var/lib/wastebin/sqlite3.db";
      };
    };
  };
}
