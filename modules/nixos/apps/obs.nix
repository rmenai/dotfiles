{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.obs;
  nvidiaEnabled = lib.elem "nvidia" config.services.xserver.videoDrivers;
in
{
  options.features.apps.obs = {
    enable = lib.mkEnableOption "OBS Studio";
  };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        programs.obs-studio = {
          enable = true;
          enableVirtualCamera = true;

          package = pkgs.obs-studio.override { cudaSupport = nvidiaEnabled; };

          plugins = with pkgs.obs-studio-plugins; [
            wlrobs
            obs-backgroundremoval
            obs-pipewire-audio-capture
            obs-gstreamer
            obs-vkcapture
            droidcam-obs
          ];
        };

        boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
        boot.kernelModules = [ "v4l2loopback" ];
        security.polkit.enable = true;

        users.users.${config.spec.user}.extraGroups = [ "video" ];
      }

      (lib.mkIf nvidiaEnabled {
        environment.variables.OBS_USE_EGL = "1";
      })
    ]
  );
}
