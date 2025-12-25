{ config, lib, ... }:
let
  cfg = config.features.services.searxng;
in
{
  options.features.services.searxng = {
    enable = lib.mkEnableOption "Private search bar";
  };

  config = lib.mkIf cfg.enable {
    sops.secrets."secrets/searxng" = { };

    services.searx = {
      enable = true;
      environmentFile = config.sops.secrets."secrets/searxng".path;
      settings = {
        server = {
          bind_address = "0.0.0.0";
          port = 9080;
          secret_key = "@SEARX_SECRET_KEY@";
          default_locale = "en";
        };
      };
    };
  };
}
