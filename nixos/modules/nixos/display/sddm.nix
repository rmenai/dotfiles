{ config, lib, pkgs, ... }: {
  options.features.display.sddm = {
    enable = lib.mkEnableOption "SDDM display manager";

    wayland = {
      enable = lib.mkEnableOption "Wayland support for SDDM" // {
        default = true;
      };
    };

  };

  options.features.display.autoLogin = {
    enable = lib.mkEnableOption "automatic login";
    user = lib.mkOption {
      type = lib.types.str;
      default = config.spec.user or "";
      description = "User to automatically log in";
    };
  };

  config = lib.mkIf config.features.display.sddm.enable {
    services.displayManager = {
      sddm = {
        enable = true;
        package = pkgs.kdePackages.sddm;
        wayland.enable = config.features.display.sddm.wayland.enable;
      };

      autoLogin = lib.mkIf config.features.display.autoLogin.enable {
        enable = true;
        user = config.features.display.autoLogin.user;
      };
    };

    features.persist = {
      directories = {
        "/var/lib/sddm" = true;
        "/usr/share/sddm" = true;
      };
    };
  };
}
