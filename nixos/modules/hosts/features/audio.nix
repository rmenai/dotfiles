{
  config,
  lib,
  pkgs,
  ...
}: {
  options.features.audio = {
    enable = lib.mkEnableOption "audio support";
    lowLatency = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable low-latency audio configuration";
    };
    bluetooth = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable bluetooth audio support";
    };
  };

  config = lib.mkIf config.features.audio.enable {
    security.rtkit.enable = true;
    services.pulseaudio.enable = false;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = config.features.audio.lowLatency;
    };

    services.pipewire.wireplumber.extraConfig = lib.mkIf config.features.audio.bluetooth {
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
  };
}
