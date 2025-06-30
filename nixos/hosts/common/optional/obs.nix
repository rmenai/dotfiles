{
  pkgs,
  config,
  ...
}: {
  programs.obs-studio = {
    enable = true;
    enableVirtualCamera = true;

    # optional Nvidia hardware acceleration
    package = (
      pkgs.obs-studio.override {
        cudaSupport = true;
      }
    );

    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-gstreamer
      obs-vkcapture
      droidcam-obs
    ];
  };

  boot.extraModulePackages = with config.boot.kernelPackages; [v4l2loopback];
  boot.kernelModules = [
    "v4l2loopback"
  ];
  security.polkit.enable = true;
}
