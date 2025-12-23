{ config, lib, ... }:
{
  options.features.services.networking.omnitools = {
    enable = lib.mkEnableOption "Tools";
  };

  config = lib.mkIf config.features.services.networking.omnitools.enable {
    virtualisation.oci-containers.containers."omnitools" = {
      image = "iib0011/omni-tools:latest";
      ports = [ "127.0.0.1:8080:80" ];
    };
  };
}
