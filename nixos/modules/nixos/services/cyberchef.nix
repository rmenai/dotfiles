{ config, lib, ... }:
let
  cfg = config.features.services.cyberchef;
in
{
  options.features.services.cyberchef = {
    enable = lib.mkEnableOption "Cyberchef";
  };

  config = lib.mkIf cfg.enable {
    virtualisation.oci-containers.containers."cyberchef" = {
      image = "ghcr.io/gchq/cyberchef:latest";
      ports = [ "127.0.0.1:8083:80" ];
    };
  };
}
