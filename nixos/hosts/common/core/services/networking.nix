{config, ...}: {
  networking = {
    hostName = config.spec.hostName;
    networkmanager.enable = true;
  };

  environment.persistence."/persist/system" = {
    directories = [
      "/var/lib/bluetooth"
      "/var/lib/NetworkManager"
      "/etc/NetworkManager/system-connections"
    ];
  };
}
