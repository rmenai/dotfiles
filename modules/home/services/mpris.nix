{ config, lib, ... }:
let
  cfg = config.features.services.mpris;
in
{
  options.features.services.mpris = {
    enable = lib.mkEnableOption "MPRIS proxy service";
  };

  config = lib.mkIf cfg.enable {
    services.mpris-proxy.enable = true;
  };
}
