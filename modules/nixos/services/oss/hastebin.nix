{ config, lib, ... }:
let
  cfg = config.features.services.hastebin;
in
{
  options.features.services.hastebin = {
    enable = lib.mkEnableOption "Hastebin pastebin service";
  };

  config = lib.mkIf cfg.enable {
    virtualisation.oci-containers.containers."hastebin" = {
      image = "rlister/hastebin";
      ports = [ "127.0.0.1:7777:7777" ];
      extraOptions = [ "--pull=always" ];
      environment = {
        STORAGE_TYPE = "file";
      };
    };
  };
}
