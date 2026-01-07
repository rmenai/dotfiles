{ config, lib, ... }:
let
  cfg = config.features.services.syncthing;
  persistFolder = config.spec.persistFolder;
in
{
  options.features.services.syncthing = {
    enable = lib.mkEnableOption "Syncthing file sync";
  };

  config = lib.mkIf cfg.enable {
    services.syncthing = {
      enable = true;
      user = config.spec.user;
      dataDir = "/home/${config.spec.user}";
      configDir = "/home/${config.spec.user}/.config/syncthing";
      guiAddress = "0.0.0.0:8384";
      settings = {
        devices = {
          "null" = {
            id = config.private.secrets.syncthingDevices.null;
          };
          "s23" = {
            id = config.private.secrets.syncthingDevices.s23;
          };
          "kernel" = {
            id = config.private.secrets.syncthingDevices.kernel;
          };
        };
      };
    };

    environment.persistence.${persistFolder}.directories = [
      "/var/lib/syncthing"
    ];
  };
}
