{ config, lib, ... }: {
  options.features.services.mpris = {
    enable = lib.mkEnableOption "MPRIS proxy service";
  };

  config = lib.mkIf config.features.services.mpris.enable {
    services.mpris-proxy.enable = true;
  };
}
