{ config, lib, ... }: {
  options.features.services.networking.searxng = {
    enable = lib.mkEnableOption "Private search bar";
  };

  config = lib.mkIf config.features.services.networking.searxng.enable {
    sops.secrets."secrets/searxng" = { };

    services.searx = {
      enable = true;
      environmentFile = config.sops.secrets."secrets/searxng".path;
      settings = {
        server.bind_address = "0.0.0.0";
        server.port = 9080;
        server.secret_key = "@SEARX_SECRET_KEY@";
        server.default_locale = "en";
      };
    };
  };
}
