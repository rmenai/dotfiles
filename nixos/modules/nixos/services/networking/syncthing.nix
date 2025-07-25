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
    };

    features.persist = {
      directories = { "/var/lib/syncthing" = lib.mkDefault true; };
    };
  };
}
