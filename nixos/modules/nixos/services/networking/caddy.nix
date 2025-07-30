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
          "github.com/WeidiDeng/caddy-cloudflare-ip@v0.0.0-20231130002422-f53b62aa13cb"
        ];

        hash = "sha256-dEkr9u6WokYjC+6gT9WZ3kF/yGBYTn+NQe5rpmitRW8=";
      };
    };

    features.persist = { directories = { "/var/lib/caddy" = true; }; };
  };
}
