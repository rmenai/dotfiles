{config, ...}: {
  networking = {
    hostName = config.spec.hostName;
    networkmanager.enable = true;
  };

  features.persist = {
    directories = {
      "/var/lib/bluetooth" = true;
      "/var/lib/NetworkManager" = true;
      "/etc/NetworkManager/system-connections" = true;
    };
  };
}
