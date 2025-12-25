{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.services.unbound;
in
{
  options.features.services.unbound = {
    enable = lib.mkEnableOption "Unbound DNS resolver";
  };

  config = lib.mkIf cfg.enable {
    services.unbound = {
      enable = true;
      settings = {
        server = {
          # Listen on localhost (IPv4 and IPv6)
          interface = [
            "127.0.0.1"
            "::1"
          ];

          # Basic IP settings
          do-ip4 = true;
          do-ip6 = true;
          prefer-ip6 = false;

          # Security hardening
          hide-identity = true;
          hide-version = true;
          harden-glue = true;
          harden-dnssec-stripped = true;
          harden-below-nxdomain = true;
          harden-referral-path = true;
          use-caps-for-id = true;

          # Performance optimizations
          num-threads = 4;
          msg-cache-slabs = 8;
          rrset-cache-slabs = 8;
          infra-cache-slabs = 8;
          key-cache-slabs = 8;

          # Cache settings for better performance
          cache-min-ttl = 0;
          cache-max-ttl = 86400;
          msg-cache-size = "50m";
          rrset-cache-size = "100m";

          # Prefetch popular domains
          prefetch = true;
          prefetch-key = true;

          # Enable DNSSEC validation
          auto-trust-anchor-file = "/var/lib/unbound/root.key";

          # Rate limiting to prevent abuse
          ratelimit = 1000;

          # Access control (only localhost)
          access-control = [
            "0.0.0.0/0 refuse"
            "127.0.0.0/8 allow"
            "::0/0 refuse"
            "::1 allow"
          ];

          # Network settings
          so-rcvbuf = "1m";
          so-sndbuf = "1m";

          # Minimize information leakage
          qname-minimisation = true;
          aggressive-nsec = true;
        };

        # Use DNS over TLS for privacy and security
        forward-zone = [
          {
            name = ".";
            forward-addr = [
              # Cloudflare DNS with DNS-over-TLS
              "1.1.1.1@853#cloudflare-dns.com"
              "1.0.0.1@853#cloudflare-dns.com"
              "2606:4700:4700::1111@853#cloudflare-dns.com"
              "2606:4700:4700::1001@853#cloudflare-dns.com"
              # Quad9 DNS with DNS-over-TLS (alternative)
              # "9.9.9.9@853#dns.quad9.net"
              # "149.112.112.112@853#dns.quad9.net"
            ];
            forward-tls-upstream = true;
          }
        ];
      };
    };

    environment.systemPackages = with pkgs; [ unbound ];
  };
}
