{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.features.apps.obs = {
    enable = lib.mkEnableOption "OBS Studio";
  };

  config = lib.mkIf config.features.apps.obs.enable {
    programs.obs-studio = {
      enable = true;
      enableVirtualCamera = true;

      package = (pkgs.stable.obs-studio.override { cudaSupport = true; });

      plugins = with pkgs.stable.obs-studio-plugins; [
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
  };
}
