{ config, lib, ... }:
{
  options.features.services.networking.resolved = {
    enable = lib.mkEnableOption "systemd-resolved dns";
  };

  config = lib.mkIf config.features.services.networking.resolved.enable {
    services.resolved = {
      enable = true;
      domains = [ "~." ];
      dnsovertls = "opportunistic";
      dnssec = "allow-downgrade";

      fallbackDns = [
        "1.1.1.1#cloudflare-dns.com"
        "1.0.0.1#cloudflare-dns.com"
        "9.9.9.9#dns.quad9.net"
        "149.112.112.112#dns.quad9.net"
      ];
    };
  };
}
