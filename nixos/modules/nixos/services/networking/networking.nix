{ config, lib, ... }: {
  options.features.services.networking = {
    networkd = { enable = lib.mkEnableOption "systemd-networkd"; };
    networkManager = { enable = lib.mkEnableOption "NetworkManager"; };
  };

  config = lib.mkMerge [
    (lib.mkIf config.features.services.networking.networkd.enable {
      networking.useNetworkd = true;
      systemd.network.enable = true;
    })

    (lib.mkIf config.features.services.networking.networkManager.enable {
      networking.networkmanager.enable = true;

      users.users.${config.spec.user}.extraGroups = [ "networkmanager" ];

      features.persist = {
        directories = {
          "/var/lib/bluetooth" = true;
          "/var/lib/NetworkManager" = true;
          "/etc/NetworkManager/system-connections" = true;
        };
      };
    })
  ];
}
