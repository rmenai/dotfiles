{ config, lib, ... }:
let
  cfg = config.features.services.komga;
in
{
  options.features.services.komga = {
    enable = lib.mkEnableOption "Digital Comis Library";
  };

  config = lib.mkIf cfg.enable {
    services.komga = {
      enable = true;
      stateDir = "/var/lib/komga";
      settings.server.port = 10080;
    };
  };
}
