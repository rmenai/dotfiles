{ config, lib, ... }: {
  options.features.services.networking.cyberchef = {
    enable = lib.mkEnableOption "Cyberchef";
  };

  config = lib.mkIf config.features.services.networking.cyberchef.enable {
    virtualisation.oci-containers.containers."cyberchef" = {
      image = "ghcr.io/gchq/cyberchef:latest";
      ports = [ "127.0.0.1:8083:80" ];
    };
  };
}
