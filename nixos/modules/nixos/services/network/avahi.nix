{ config, lib, ... }:
let
  cfg = config.features.services.avahi;
in
{
  options.features.services.avahi = {
    enable = lib.mkEnableOption "Avahi local DNS sharing";
  };

  config = lib.mkIf cfg.enable {
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      domainName = "local";
      publish = {
        enable = true;
        addresses = true;
        workstation = true;
      };
    };
  };
}
