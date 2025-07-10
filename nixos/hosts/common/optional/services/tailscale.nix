{pkgs, ...}: {
  services.tailscale.enable = true;
  networking.firewall.allowedUDPPorts = [41641];
  environment.systemPackages = [pkgs.tailscale];

  features.persist = {
    directories = {
      "/var/lib/tailscale" = true;
    };
  };
}
