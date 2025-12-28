{ config, lib, ... }:
let
  cfg = config.features.desktop.sddm;
in
{
  options.features.desktop.sddm = {
    enable = lib.mkEnableOption "SDDM display manager";

    wayland = {
      enable = lib.mkEnableOption "Wayland support for SDDM" // {
        default = true;
      };
    };

  };

  config = lib.mkIf cfg.enable {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = cfg.wayland.enable;
    };
  };
}
