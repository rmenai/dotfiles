{ config, lib, ... }: {
  options.features.services.networking.resolved = {
    enable = lib.mkEnableOption "systemd-resolved dns";
  };

  config = lib.mkIf config.features.services.networking.resolved.enable {
    services.resolved = {
      enable = true;
      # Use DNS-over-TLS opportunistically.
      # 'opportunistic' is best for laptops as it tries to use encrypted DNS but
      # won't fail if a network (like a hotel captive portal) blocks it.
      dnsovertls = "opportunistic";

      # Use a set of fast, privacy-focused DNS providers.
      # The #hostname part is crucial for DoT certificate validation.
      fallbackDns = [
        "1.1.1.1#cloudflare-dns.com" # Cloudflare Primary
        "1.0.0.1#cloudflare-dns.com" # Cloudflare Secondary
        "9.9.9.9#dns.quad9.net" # Quad9 Primary (Security-focused)
        "149.112.112.112#dns.quad9.net" # Quad9 Secondary
      ];

      # Enable DNSSEC but allow it to be disabled if the upstream server doesn't support it.
      # This prevents DNS resolution failures on misconfigured networks.
      dnssec = "allow-downgrade";

      # Enable local DNS caching to speed up repeated lookups.
      extraConfig = ''
        Cache=yes
      '';
    };
  };
}
