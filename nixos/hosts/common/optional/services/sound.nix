{pkgs, ...}: let
  speakerScript = pkgs.writeShellScript "turn-on-speakers" ''
    export TERM=linux
    # Some distros don't have i2c-dev module loaded by default, so we load it manually
    ${pkgs.kmod}/bin/modprobe i2c-dev

    # Function to find the correct I2C bus (third DesignWare adapter)
    find_i2c_bus() {
        local adapter_description="Synopsis DesignWare I2C adapter"
        local dw_count=$(${pkgs.i2c-tools}/bin/i2cdetect -l | ${pkgs.gnugrep}/bin/grep -c "$adapter_description")
        if [ "$dw_count" -lt 3 ]; then
            echo "Error: Less than 3 DesignWare I2C adapters found." >&2
            return 1
        fi
        local bus_number=$(${pkgs.i2c-tools}/bin/i2cdetect -l | ${pkgs.gnugrep}/bin/grep "$adapter_description" | ${pkgs.gawk}/bin/awk '{print $1}' | ${pkgs.gnused}/bin/sed 's/i2c-//' | ${pkgs.gnused}/bin/sed -n '3p')
        echo "$bus_number"
    }

    i2c_bus=$(find_i2c_bus)
    if [ -z "$i2c_bus" ]; then
        echo "Error: Could not find the third DesignWare I2C bus for the audio IC." >&2
        exit 1
    fi
    echo "Using I2C bus: $i2c_bus"
    i2c_addr=(0x3f 0x38)

    count=0
    for value in "''${i2c_addr[@]}"; do
        val=$((count % 2))
        ${pkgs.i2c-tools}/bin/i2cset -f -y "$i2c_bus" "$value" 0x00 0x00
        ${pkgs.i2c-tools}/bin/i2cset -f -y "$i2c_bus" "$value" 0x7f 0x00
        ${pkgs.i2c-tools}/bin/i2cset -f -y "$i2c_bus" "$value" 0x01 0x01
        ${pkgs.i2c-tools}/bin/i2cset -f -y "$i2c_bus" "$value" 0x0e 0xc4
        ${pkgs.i2c-tools}/bin/i2cset -f -y "$i2c_bus" "$value" 0x0f 0x40
        ${pkgs.i2c-tools}/bin/i2cset -f -y "$i2c_bus" "$value" 0x5c 0xd9
        ${pkgs.i2c-tools}/bin/i2cset -f -y "$i2c_bus" "$value" 0x60 0x10
        if [ $val -eq 0 ]; then
            ${pkgs.i2c-tools}/bin/i2cset -f -y "$i2c_bus" "$value" 0x0a 0x1e
        else
            ${pkgs.i2c-tools}/bin/i2cset -f -y "$i2c_bus" "$value" 0x0a 0x2e
        fi
        ${pkgs.i2c-tools}/bin/i2cset -f -y "$i2c_bus" "$value" 0x0d 0x01
        ${pkgs.i2c-tools}/bin/i2cset -f -y "$i2c_bus" "$value" 0x16 0x40
        ${pkgs.i2c-tools}/bin/i2cset -f -y "$i2c_bus" "$value" 0x00 0x01
        ${pkgs.i2c-tools}/bin/i2cset -f -y "$i2c_bus" "$value" 0x17 0xc8
        ${pkgs.i2c-tools}/bin/i2cset -f -y "$i2c_bus" "$value" 0x00 0x04
        ${pkgs.i2c-tools}/bin/i2cset -f -y "$i2c_bus" "$value" 0x30 0x00
        ${pkgs.i2c-tools}/bin/i2cset -f -y "$i2c_bus" "$value" 0x31 0x00
        ${pkgs.i2c-tools}/bin/i2cset -f -y "$i2c_bus" "$value" 0x32 0x00
        ${pkgs.i2c-tools}/bin/i2cset -f -y "$i2c_bus" "$value" 0x33 0x01

        ${pkgs.i2c-tools}/bin/i2cset -f -y "$i2c_bus" "$value" 0x00 0x08
        ${pkgs.i2c-tools}/bin/i2cset -f -y "$i2c_bus" "$value" 0x18 0x00
        ${pkgs.i2c-tools}/bin/i2cset -f -y "$i2c_bus" "$value" 0x19 0x00
        ${pkgs.i2c-tools}/bin/i2cset -f -y "$i2c_bus" "$value" 0x1a 0x00
        ${pkgs.i2c-tools}/bin/i2cset -f -y "$i2c_bus" "$value" 0x1b 0x00
        ${pkgs.i2c-tools}/bin/i2cset -f -y "$i2c_bus" "$value" 0x28 0x40
        ${pkgs.i2c-tools}/bin/i2cset -f -y "$i2c_bus" "$value" 0x29 0x00
        ${pkgs.i2c-tools}/bin/i2cset -f -y "$i2c_bus" "$value" 0x2a 0x00
        ${pkgs.i2c-tools}/bin/i2cset -f -y "$i2c_bus" "$value" 0x2b 0x00

        ${pkgs.i2c-tools}/bin/i2cset -f -y "$i2c_bus" "$value" 0x00 0x0a
        ${pkgs.i2c-tools}/bin/i2cset -f -y "$i2c_bus" "$value" 0x48 0x00
        ${pkgs.i2c-tools}/bin/i2cset -f -y "$i2c_bus" "$value" 0x49 0x00
        ${pkgs.i2c-tools}/bin/i2cset -f -y "$i2c_bus" "$value" 0x4a 0x00
        ${pkgs.i2c-tools}/bin/i2cset -f -y "$i2c_bus" "$value" 0x4b 0x00
        ${pkgs.i2c-tools}/bin/i2cset -f -y "$i2c_bus" "$value" 0x58 0x40
        ${pkgs.i2c-tools}/bin/i2cset -f -y "$i2c_bus" "$value" 0x59 0x00
        ${pkgs.i2c-tools}/bin/i2cset -f -y "$i2c_bus" "$value" 0x5a 0x00
        ${pkgs.i2c-tools}/bin/i2cset -f -y "$i2c_bus" "$value" 0x5b 0x00

        ${pkgs.i2c-tools}/bin/i2cset -f -y "$i2c_bus" "$value" 0x00 0x00
        ${pkgs.i2c-tools}/bin/i2cset -f -y "$i2c_bus" "$value" 0x02 0x00
        count=$((count + 1))
    done
  '';
in {
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

  # services.pipewire.extraConfig.pipewire."99-disable-rate-switching" = {
  #   "context.properties" = {
  #     "default.clock.rate" = 48000;
  #     "default.clock.allowed-rates" = [48000];
  #   };
  # };

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

  # # Disable runtime power management for I2C devices
  # services.udev.extraRules = ''
  #   SUBSYSTEM=="i2c", ATTR{power/control}="on"
  #   SUBSYSTEM=="i2c", KERNEL=="i2c-17", ATTR{power/control}="on"
  # '';

  systemd.services.turn-on-speakers = {
    description = "Turn on speakers using i2c configuration";
    after = ["suspend.target" "hibernate.target" "hybrid-sleep.target" "suspend-then-hibernate.target"];

    serviceConfig = {
      User = "root";
      Type = "oneshot";
      ExecStart = "${speakerScript}";
    };
    wantedBy = ["multi-user.target" "sleep.target"];
  };
}
