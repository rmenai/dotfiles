{ config, lib, ... }:
let
  cfg = config.features.desktop.void;
in
{
  config = lib.mkIf cfg.enable {
    services.cliphist = {
      systemdTargets = [ "graphical-session.target" ];
    };
  };
}
