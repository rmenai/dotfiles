{
  networking = {
    hostName = "kagi";
    useNetworkd = true;
    useDHCP = false;

    firewall = {
      enable = true;
      allowPing = true;
      allowedTCPPorts = [ 22 ];
    };
  };

  # Automatically grab an IP via DHCP on the primary OVH interface
  systemd.network = {
    enable = true;
    networks."10-wan" = {
      matchConfig.Name = "en* eth*";
      networkConfig.DHCP = "yes";
    };
  };
}
