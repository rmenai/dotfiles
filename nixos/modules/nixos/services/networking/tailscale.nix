{ config, lib, pkgs, ... }: {
  options.features.services.networking.tailscale = {
    enable = lib.mkEnableOption "Tailscale VPN";
  };

  config = lib.mkIf config.features.services.networking.tailscale.enable {
    services.tailscale.enable = true;
    networking.firewall.allowedUDPPorts = [ 41641 ];
    environment.systemPackages = [ pkgs.tailscale ];

    features.persist = { directories = { "/var/lib/tailscale" = true; }; };
  };
}
