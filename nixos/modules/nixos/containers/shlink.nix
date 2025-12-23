{ config, lib, ... }:
{
  options.features.containers.shlink = {
    enable = lib.mkEnableOption "URL Shortener";

    environment = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = { };
      description = "Environment variables for Shlink container";
    };
  };

  config = lib.mkIf config.features.containers.shlink.enable {
    virtualisation.oci-containers.containers."shlink" = {
      image = "shlinkio/shlink:stable";
      ports = [ "127.0.0.1:8385:8385" ];
      extraOptions = [ "--pull=always" ];
      environment = config.features.containers.shlink.environment;
    };
  };
}
