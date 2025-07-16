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
      address = [ "159.223.238.92/20" "10.18.0.5/16" ];
      routes = [{ routeConfig.Gateway = "159.223.224.1"; }];
      dns = [ "8.8.8.8" ];
    };

    networks."20-eth1" = {
      matchConfig.Name = "eth1";
      address = [ "10.110.0.5/20" ];
    };
  };

  services.udev.extraRules = ''
    ATTR{address}=="b6:9a:16:4e:36:c3", NAME="eth0"
    ATTR{address}=="0a:5b:77:ce:84:43", NAME="eth1"
  '';
}
