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

  options.features.desktop.autoLogin = {
    enable = lib.mkEnableOption "automatic login";
    user = lib.mkOption {
      type = lib.types.str;
      default = config.spec.user or "";
      description = "User to automatically log in";
    };
  };

  config = lib.mkIf cfg.enable {
    services.displayManager = {
      sddm = {
        enable = true;
        wayland.enable = cfg.wayland.enable;
      };

      autoLogin = lib.mkIf config.features.desktop.autoLogin.enable {
        enable = true;
        user = config.features.desktop.autoLogin.user;
      };
    };
  };
}
