{ config, lib, ... }:
let
  cfg = config.features.services.omnitools;
in
{
  options.features.services.omnitools = {
    enable = lib.mkEnableOption "Tools";
  };

  config = lib.mkIf cfg.enable {
    virtualisation.oci-containers.containers."omnitools" = {
      image = "iib0011/omni-tools:latest";
      ports = [ "127.0.0.1:8080:80" ];
    };
  };
}
