{ lib, ... }: {
  # This file was populated at runtime with the networking
  # details gathered from the active system.
  networking = {
    nameservers = [ "8.8.8.8" ];
    defaultGateway = "46.101.192.1";

    defaultGateway6 = {
      address = "";
      interface = "eth0";
    };

    dhcpcd.enable = false;
    usePredictableInterfaceNames = lib.mkForce false;

    interfaces = {
      eth0 = {
        ipv4.addresses = [
          {
            address = "46.101.218.50";
            prefixLength = 18;
          }
          {
            address = "10.19.0.5";
            prefixLength = 16;
          }
        ];
        ipv6.addresses = [{
          address = "fe80::4056:66ff:fe26:65ab";
          prefixLength = 64;
        }];
        ipv4.routes = [{
          address = "46.101.192.1";
          prefixLength = 32;
        }];
        ipv6.routes = [{
          address = "";
          prefixLength = 128;
        }];
      };
      eth1 = {
        ipv4.addresses = [{
          address = "10.114.0.2";
          prefixLength = 20;
        }];
        ipv6.addresses = [{
          address = "fe80::f08f:54ff:fea1:af04";
          prefixLength = 64;
        }];
      };
    };
  };

  services.udev.extraRules = ''
    ATTR{address}=="42:56:66:26:65:ab", NAME="eth0"
    ATTR{address}=="f2:8f:54:a1:af:04", NAME="eth1"
  '';
}
