{pkgs, ...}: {
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.pipewire.wireplumber.extraConfig = {
    bluetoothEnhancements = {
      "monitor.bluez.properties" = {
        "bluez5.enable-sbc-xq" = true;
        "bluez5.enable-msbc" = true;
        "bluez5.enable-aptx" = true;
        "bluez5.enable-aptx-hd" = true;
        "bluez5.enable-ldac" = true;
        "bluez5.enable-le3" = true;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    easyeffects
    pulseaudio
    pavucontrol
    util-linux
    kmod
  ];
}
