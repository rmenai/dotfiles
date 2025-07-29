{ config, lib, pkgs, ... }: {
  options.features.services.networking.caddy = {
    enable = lib.mkEnableOption "Caddy reverse proxy";
  };

  config = lib.mkIf config.features.services.networking.caddy.enable {
    services.caddy = {
      enable = true;
      package = pkgs.caddy.withPlugins {
        plugins = [
          "github.com/caddy-dns/cloudflare@v0.2.1"
          "github.com/mholt/caddy-ratelimit@v0.1.0"
        ];

        hash = "sha256-4E7pRg4JPy7fT6q9fP0bCRWS7pLWNRDYHSrxC1+XrhQ=";
      };
    };

    features.persist = { directories = { "/var/lib/caddy" = true; }; };
  };
}
