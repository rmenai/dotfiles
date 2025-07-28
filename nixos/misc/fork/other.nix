{
  # services.dnsmasq = {
  #   enable = true;
  #
  #   settings = {
  #     "listen-address" = [ "100.88.112.80" ];
  #     "bind-interfaces" = true; # forces bind to those addresses
  #     "address" = [ "/lab.menai.me/100.88.112.80" ];
  #     "server" = [ "8.8.8.8" "1.1.1.1" ];
  #   };
  # };

  # services.nginx = {
  #   enable = true;
  #
  #   # HTTPS version (port 443)
  #   virtualHosts."lab.menai.me" = {
  #     enableACME = true;
  #     forceSSL = true;
  #
  #     locations."= /" = { return = "301 /status/home"; };
  #     locations."/" = { proxyPass = "http://localhost:3001"; };
  #   };
  #
  #   # virtualHosts."adguard.lab.menai.me" = {
  #   #   enableACME = true;
  #   #   forceSSL = true;
  #   #
  #   #   locations."/" = { proxyPass = "http://localhost:3000"; };
  #   # };
  #
  #   virtualHosts."syncthing.lab.menai.me" = {
  #     enableACME = true;
  #     forceSSL = true;
  #
  #     locations."/" = { proxyPass = "http://localhost:8384"; };
  #   };
  # };

  # security.acme.certs."adguard.yourdomain.com" = {
  #   listenHTTP = true;
  #   group = "adguardhome";
  # };

  # # Enable ACME for Let's Encrypt
  # security.acme = {
  #   acceptTerms = true;
  #   defaults.email = "rami@menai.me";
  #
  #   certs."adguard.lab.menai.me" = {
  #     dnsProvider = "cloudflare";
  #     dnsResolver = "1.1.1.1:53";
  #     environmentFile = config.sops.secrets."secrets/cloudflare_acme".path;
  #     webroot = null;
  #   };
  # };
}
