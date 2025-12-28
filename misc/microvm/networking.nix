{ lib, ... }:
{
  networking = {
    nameservers = [ "8.8.8.8" ];

    dhcpcd.enable = true;
    usePredictableInterfaceNames = lib.mkForce true;
  };
}
