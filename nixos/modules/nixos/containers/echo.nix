{ config, lib, ... }: {
  options.features.containers.echo = {
    enable = lib.mkEnableOption "HTTP echo service container";
  };

  config = lib.mkIf config.features.containers.echo.enable {
    virtualisation.oci-containers.containers."echo-http-service" = {
      image = "hashicorp/http-echo";
      extraOptions = [ "-text='Hello, World!'" ];
      ports = [ "5678:5678" ];
    };
  };
}
