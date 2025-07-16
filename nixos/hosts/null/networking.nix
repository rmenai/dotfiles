{ config, pkgs, ... }: {
  features.services.networking.resolved.enable = true;

  networking = {
    hostName = config.spec.host;

    networkmanager = {
      enable = true;
      wifi.powersave = false;
      dns = "systemd-resolved";
    };

    firewall = {
      enable = true;
      allowPing = true;
    };

    extraHosts = ''
      10.10.10.10 kali
      10.10.10.8  flare
    '';
  };

  boot.kernelModules = [ "tcp_bbr" ];

  hardware.firmware = [ pkgs.wireless-regdb ];

  boot.kernel.sysctl = {
    # Enable BBR congestion control
    "net.core.default_qdisc" = "fq";
    "net.ipv4.tcp_congestion_control" = "bbr";

    # Increase network buffers
    "net.core.rmem_max" = 134217728;
    "net.core.wmem_max" = 134217728;
    "net.ipv4.tcp_rmem" = "4096 87380 134217728";
    "net.ipv4.tcp_wmem" = "4096 65536 134217728";

    # TCP optimizations
    "net.ipv4.tcp_window_scaling" = 1;
    "net.ipv4.tcp_timestamps" = 1;
    "net.ipv4.tcp_sack" = 1;

    # Reduce TIME_WAIT socket time
    "net.ipv4.tcp_fin_timeout" = 30;

    # Network queue optimizations
    "net.core.netdev_max_backlog" = 5000;
    "net.core.netdev_budget" = 300;
  };

  users.users.${config.spec.user}.extraGroups = [ "networkmanager" ];

  features.persist = {
    directories = {
      "/var/lib/NetworkManager" = true;
      "/etc/NetworkManager/system-connections" = true;
    };
  };
}
