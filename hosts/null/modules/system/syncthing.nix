{ config, ... }:
{
  services.syncthing = {
    enable = true;
    user = "vault";
    dataDir = "/home/vault";
    configDir = "/home/vault/.config/syncthing";
    guiAddress = "0.0.0.0:8384";
    settings = {
      devices = {
        "null" = {
          id = config.private.syncthingDevices.null;
        };
        "s23" = {
          id = config.private.syncthingDevices.s23;
        };
      };
    };
  };
}
