{
  config,
  lib,
  pkgs,
  ...
}:
{
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
          "github.com/WeidiDeng/caddy-cloudflare-ip@v0.0.0-20231130002422-f53b62aa13cb"
        ];

        hash = "sha256-nafCoLotyb+P9JjcIUW9/eBE1NzASA2S/1iyoACB2Hw=";
      };
    };

    features.persist = {
      directories = {
        "/var/lib/caddy" = true;
      };
    };
  };
}
