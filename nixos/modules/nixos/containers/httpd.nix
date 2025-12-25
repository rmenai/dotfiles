{ config, lib, ... }:
let
  cfg = config.features.containers.httpd;
in
{
  options.features.containers.httpd = {
    enable = lib.mkEnableOption "Apache HTTPD container";
  };

  config = lib.mkIf cfg.enable {
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
