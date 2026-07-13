{
  services.resolved = {
    enable = true;

    settings.Resolve = {
      Domains = [ "~." ];
      DNSOverTLS = "opportunistic";
      DNSSEC = "allow-downgrade";

      FallbackDNS = [
        "1.1.1.1#cloudflare-dns.com"
        "1.0.0.1#cloudflare-dns.com"
        "9.9.9.9#dns.quad9.net"
        "149.112.112.112#dns.quad9.net"
      ];
    };
  };

  networking = {
    hostName = "null";

    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
    };

    firewall = {
      enable = true;
      allowPing = true;
      trustedInterfaces = [ "tailscale0" ];
      allowedTCPPorts = [ ];
      allowedUDPPorts = [ 41641 ]; # Tailscale default
    };

    extraHosts = ''
      10.10.10.10 kali
      10.10.10.8  flare
    '';
  };

  boot = {
    kernelModules = [ "tcp_bbr" ];

    kernel.sysctl = {
      # Use BBR for better throughput on high-latency or lossy links
      "net.core.default_qdisc" = "fq";
      "net.ipv4.tcp_congestion_control" = "bbr";

      # Increase network buffer sizes for high-speed links
      "net.core.rmem_max" = 134217728;
      "net.core.wmem_max" = 134217728;
      "net.ipv4.tcp_rmem" = "4096 87380 134217728";
      "net.ipv4.tcp_wmem" = "4096 65536 134217728";

      # TCP Window Scaling and Timestamps
      "net.ipv4.tcp_window_scaling" = 1;
      "net.ipv4.tcp_timestamps" = 1;
      "net.ipv4.tcp_sack" = 1;

      # Socket Cleanup Optimizations
      "net.ipv4.tcp_fin_timeout" = 30;
      "net.core.netdev_max_backlog" = 5000;
      "net.core.netdev_budget" = 300;
    };

    extraModprobeConfig = ''
      options cfg80211 ieee80211_regdom="FR"
    '';
  };

  hardware.wirelessRegulatoryDatabase = true;
}
