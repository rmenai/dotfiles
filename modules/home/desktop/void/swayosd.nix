{ config, lib, ... }:
let
  cfg = config.features.desktop.void;
in
{
  config = lib.mkIf cfg.enable {
    services.swayosd = {
      enable = true;
      topMargin = 0.03;
    };
  };
}
