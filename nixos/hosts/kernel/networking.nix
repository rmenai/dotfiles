{
  networking = {
    useNetworkd = true;
    usePredictableInterfaceNames = false;
    dhcpcd.enable = false;
  };

  systemd.network = {
    enable = true;

    networks."10-eth0" = {
      matchConfig.Name = "eth0";
      address = [ "167.99.219.56/20" "10.18.0.6/16" ];
      routes = [{ Gateway = "167.99.208.1"; }];
      dns = [ "8.8.8.8" ];
    };

    networks."20-eth1" = {
      matchConfig.Name = "eth1";
      address = [ "10.110.0.4/20" ];
    };
  };

  services.udev.extraRules = ''
    ATTR{address}=="ce:93:e8:f9:b7:a2", NAME="eth0"
    ATTR{address}=="96:3f:75:64:a3:0d", NAME="eth1"
  '';
}
