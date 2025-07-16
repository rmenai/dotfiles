{ config, lib, ... }: {
  options.features.containers.httpd = {
    enable = lib.mkEnableOption "Apache HTTPD container";
  };

  config = lib.mkIf config.features.containers.httpd.enable {
    containers.httpd = {
      autoStart = true;
      config = {
        services.httpd = {
          enable = true;
          adminAddr = "foo@example.org";
        };
      };
    };
  };
}
