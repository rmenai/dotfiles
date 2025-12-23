{ config, lib, ... }:
{
  options.features.services.networking.privatebin = {
    enable = lib.mkEnableOption "Privatebin sharing service";
  };

  config = lib.mkIf config.features.services.networking.privatebin.enable {
    services.privatebin = {
      enable = true;
      user = "privatebin";
      group = "caddy";

      poolConfig = {
        "listen.owner" = "privatebin";
        "listen.group" = "caddy";
        "listen.mode" = "0660";
      };

      settings = {
        expire_options = {
          "5min" = 300;
          "10min" = 600;
          "1hour" = 3600;
          "1day" = 86400;
          "1week" = 604800;
          "1month" = 2592000;
          "1year" = 31536000;
          "never" = 0;
        };

        traffic = {
          limit = 10;
        };

        purge = {
          limit = 3600;
          batchsize = 10;
        };

        model = {
          class = "Filesystem";
        };
        model_options = {
          dir = "/var/lib/privatebin";
        };
      };
    };

    features.persist = {
      directories = {
        "/var/lib/privatebin" = lib.mkDefault true;
      };
    };
  };
}
