{ lib, ... }: {
  networking = {
    useNetworkd = true;
    usePredictableInterfaceNames = lib.mkForce false;
    dhcpcd.enable = false;
  };

  systemd.network = {
    enable = true;

    networks."10-eth0" = {
      matchConfig.Name = "eth0";
      address = [ "165.232.82.203/20" "10.18.0.6/16" ];
      routes = [{ routeConfig.Gateway = "165.232.80.1"; }];
      dns = [ "8.8.8.8" ];
    };

    networks."20-eth1" = {
      matchConfig.Name = "eth1";
      address = [ "10.110.0.2/20" ];
    };
  };

  services.udev.extraRules = ''
    ATTR{address}=="b2:b9:7a:72:a9:20", NAME="eth0"
    ATTR{address}=="9a:24:f5:ac:aa:cb", NAME="eth1"
  '';
}
