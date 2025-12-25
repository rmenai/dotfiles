{ config, lib, ... }:
let
  cfg = config.features.containers.echo;
in
{
  options.features.containers.echo = {
    enable = lib.mkEnableOption "HTTP echo service container";
  };

  config = lib.mkIf cfg.enable {
    virtualisation.oci-containers.containers."echo-http-service" = {
      image = "hashicorp/http-echo";
      extraOptions = [ "-text='Hello, World!'" ];
      ports = [ "127.0.0.1:5678:5678" ];
    };
  };
}
