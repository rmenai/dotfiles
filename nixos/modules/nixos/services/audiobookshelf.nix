{ config, lib, ... }:
let
  cfg = config.features.services.audiobookshelf;
in
{
  options.features.services.audiobookshelf = {
    enable = lib.mkEnableOption "AudioBookshelf";
  };

  config = lib.mkIf cfg.enable {
    services.audiobookshelf = {
      enable = true;
      dataDir = "audiobookshelf";
      host = "0.0.0.0";
      port = 8000;
    };
  };
}
