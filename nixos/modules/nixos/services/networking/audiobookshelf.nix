{ config, lib, ... }:
{
  options.features.services.networking.audiobookshelf = {
    enable = lib.mkEnableOption "AudioBookshelf";
  };

  config = lib.mkIf config.features.services.networking.audiobookshelf.enable {
    services.audiobookshelf = {
      enable = true;
      dataDir = "audiobookshelf";
      host = "0.0.0.0";
      port = 8000;
    };

    features.persist = {
      directories = {
        "/var/lib/audiobookshelf" = lib.mkDefault true;
      };
    };
  };
}
