{ config, lib, ... }:
{
  options.features.services.networking.hastebin = {
    enable = lib.mkEnableOption "Hastebin pastebin service";
  };

  config = lib.mkIf config.features.services.networking.hastebin.enable {
    virtualisation.oci-containers.containers."hastebin" = {
      image = "rlister/hastebin";
      ports = [ "127.0.0.1:7777:7777" ];
      extraOptions = [ "--pull=always" ];
      environment = {
        STORAGE_TYPE = "file";
      };
    };

    features.persist = {
      directories = {
        "/var/lib/hastebin" = lib.mkDefault true;
      };
    };
  };
}
