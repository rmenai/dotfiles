{ config, lib, ... }: {
  options.features.services.networking.syncthing = {
    enable = lib.mkEnableOption "Syncthing file sync";
  };

  config = lib.mkIf config.features.services.networking.syncthing.enable {
    services.syncthing = {
      enable = true;
      user = config.spec.user;
      dataDir = "/home/${config.spec.user}";
      configDir = "/home/${config.spec.user}/.config/syncthing";
      guiAddress = "0.0.0.0:8384";
      settings = {
        devices = {
          "null" = { id = config.private.secrets.syncthingDevices.null; };
          "s23" = { id = config.private.secrets.syncthingDevices.s23; };
          "kernel" = { id = config.private.secrets.syncthingDevices.kernel; };
        };
      };
    };

    features.persist = {
      directories = { "/var/lib/syncthing" = lib.mkDefault true; };
    };
  };
}
