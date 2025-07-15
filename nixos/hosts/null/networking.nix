{
  systemd.network.networks."10-wlp0s20f3" = {
    matchConfig.Name = "wlp0s20f3";
    networkConfig.DHCP = "yes";
  };

  networking.extraHosts = ''
    10.10.10.10 kali
    10.10.10.8  flare
  '';
}
