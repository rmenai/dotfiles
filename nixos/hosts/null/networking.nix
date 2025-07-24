{ config, pkgs, ... }:
{
  features.services.networking.resolved.enable = true;

  networking = {
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
  hardware.wirelessRegulatoryDatabase = true;

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

  boot.extraModprobeConfig = ''
    options cfg80211 ieee80211_regdom="FR"
  '';

  users.users.${config.spec.user}.extraGroups = [ "networkmanager" ];

  features.persist = {
    directories = {
      "/var/lib/NetworkManager" = true;
      "/etc/NetworkManager/system-connections" = true;
      "/var/lib/systemd/network" = true;
    };
  };
} //

# Networkd config for microvm
{
  # systemd.network.enable = false;
  # systemd.network.wait-online.enable = false;
  #
  # systemd.network.netdevs."10-microvm".netdevConfig = {
  #   Kind = "bridge";
  #   Name = "microvm";
  # };
  #
  # systemd.network.networks."10-microvm" = {
  #   matchConfig.Name = "microvm";
  #   networkConfig = {
  #     DHCPServer = "yes";
  #     IPv6SendRA = "yes";
  #     IPv4Forwarding = true; # Enable IP forwarding for NAT
  #     IPv6Forwarding = true; # Enable IP forwarding for NAT
  #   };
  #   addresses =
  #     [ { Address = "10.0.0.1/24"; } { Address = "fd12:3456:789a::1/64"; } ];
  #   ipv6Prefixes = [{ ipv6PrefixConfig.Prefix = "fd12:3456:789a::/64"; }];
  # };
  #
  # systemd.network.networks."11-microvm" = {
  #   matchConfig.Name = "vm-*";
  #   networkConfig.Bridge = "microvm";
  #   linkConfig.RequiredForOnline = false; # Don't wait for these interfaces
  # };
  #
  # networking.nat = {
  #   enable = true;
  #   enableIPv6 = true;
  #   externalInterface = "wlan0";
  #   internalInterfaces = [ "microvm" ];
  #
  #   # Optional: Port forwarding examples
  #   forwardPorts = [
  #     # Example: Forward port 8080 to a microvm
  #     # {
  #     #   proto = "tcp";
  #     #   sourcePort = 8080;
  #     #   destination = "10.0.0.10:80";
  #     # }
  #   ];
  # };
  #
  # networking.firewall = {
  #   allowedUDPPorts = [ 67 ];
  #
  #   extraCommands = ''
  #     # Allow traffic from microvm bridge to external interface
  #     iptables -I FORWARD -i microvm -j ACCEPT
  #     iptables -I FORWARD -o microvm -j ACCEPT
  #   '';
  # };
} // {
  # networking = {
  #   nat = {
  #     enable = true;
  #     enableIPv6 = true;
  #     externalInterface = "wlan0"; # or your main interface
  #     internalInterfaces = [ "microvm" ];
  #
  #     # Optional: Port forwarding examples
  #     forwardPorts = [
  #       # Example: Forward port 8080 to a microvm
  #       # {
  #       #   proto = "tcp";
  #       #   sourcePort = 8080;
  #       #   destination = "10.0.0.10:80";
  #       # }
  #     ];
  #   };
  #
  # interfaces.microvm = {
  #   ipv4.addresses = [{
  #     address = "10.0.0.1";
  #     prefixLength = 24;
  #   }];
  #   ipv6.addresses = [{
  #     address = "fd12:3456:789a::1";
  #     prefixLength = 64;
  #   }];
  # };
  #
  # bridges.microvm = { interfaces = [ ]; };

  # firewall = {
  #   allowedUDPPorts = [ 67 ]; # DHCP server
  #   extraCommands = ''
  #     # Allow traffic from microvm bridge to external interface
  #     iptables -I FORWARD -i microvm -j ACCEPT
  #     iptables -I FORWARD -o microvm -j ACCEPT
  #   '';
  # };
  # };

  # IPv6 router advertisement daemon for microvm network
  # services.radvd = {
  #   enable = true;
  #   config = ''
  #     interface microvm {
  #       AdvSendAdvert on;
  #       prefix fd12:3456:789a::/64 {
  #         AdvOnLink on;
  #         AdvAutonomous on;
  #       };
  #     };
  #   '';
  # };
}
