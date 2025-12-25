{ config, lib, ... }:
let
  cfg = config.features.desktop.xserver;
in
{
  options.features.desktop.xserver = {
    enable = lib.mkEnableOption "X11 display server configuration";

    videoDrivers = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ "nvidia" ];
      description = "Video drivers to use";
    };
  };

  config = lib.mkIf cfg.enable {
    services = {
      xserver = {
        enable = true;
        xkb = {
          layout = lib.mkDefault "us";
          variant = "";
        };

        inherit (cfg) videoDrivers;
      };

      libinput.enable = true;
    };
  };
}
