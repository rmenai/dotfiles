{ config, lib, ... }: {
  options.features.display.xserver = {
    enable = lib.mkEnableOption "X11 display server configuration";

    videoDrivers = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ "nvidia" ];
      description = "Video drivers to use";
    };
  };

  config = lib.mkIf config.features.display.xserver.enable {
    services = {
      xserver = {
        enable = true;
        videoDrivers = config.features.display.xserver.videoDrivers;
        xkb = {
          layout = lib.mkDefault "us";
          variant = "";
        };
      };

      libinput.enable = true;
    };
  };
}
