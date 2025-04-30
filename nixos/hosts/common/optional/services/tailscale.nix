{pkgs, ...}: {
  services.tailscale.enable = true;
  networking.firewall.allowedUDPPorts = [41641];
  environment.systemPackages = [pkgs.tailscale];

  environment.persistence."/persist/system" = {
    directories = [
      "/var/lib/tailscale"
    ];
  };
}
