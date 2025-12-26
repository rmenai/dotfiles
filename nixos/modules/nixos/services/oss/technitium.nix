{ config, lib, ... }:
let
  cfg = config.features.services.technitium;
in
{
  options.features.services.technitium = {
    enable = lib.mkEnableOption "Technitium DNS resolver";
  };

  config = lib.mkIf cfg.enable {
    services.technitium-dns-server = {
      enable = true;
    };
  };
}
