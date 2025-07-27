{ config, lib, ... }: {
  options.features.services.networking.technitium = {
    enable = lib.mkEnableOption "Technitium DNS resolver";
  };

  config = lib.mkIf config.features.services.networking.technitium.enable {
    services.technitium-dns-server.enable = true;
  };
}
