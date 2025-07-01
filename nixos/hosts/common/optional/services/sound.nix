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
        "bluez5.enable-hw-volume" = true;
        "bluez5.enable-le" = true;
        "bluez5.enable-lc3" = true;
        "bluez5.roles" = ["hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag"];
      };
    };
    disableX11Bell = {
      "wireplumber.profiles" = {
        main = {
          "monitor.libpipewire-module-x11-bell" = "disabled";
        };
      };
    };
  };

  services.pipewire.extraConfig.pipewire."99-disable-rate-switching" = {
    "context.properties" = {
      "default.clock.rate" = 48000;
      "default.clock.allowed-rates" = [48000];
    };
  };

  environment.systemPackages = with pkgs; [
    easyeffects
    pavucontrol
    util-linux
    kmod
    i2c-tools
    gnugrep
    gawk
    gnused
  ];

  boot.kernelModules = ["i2c-dev"];

  # Disable runtime power management for I2C devices
  services.udev.extraRules = ''
    SUBSYSTEM=="i2c", ATTR{power/control}="on"
    SUBSYSTEM=="i2c", KERNEL=="i2c-17", ATTR{power/control}="on"
  '';
}
