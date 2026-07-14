{ config, pkgs, ... }:
{
  sops.secrets."secrets/tailscale_auth_key" = {
    restartUnits = [ "tailscaled-autoconnect.service" ];
  };

  services.tailscale = {
    enable = true;
    authKeyFile = config.sops.secrets."secrets/tailscale_auth_key".path;
    useRoutingFeatures = "both";
    port = 41641;
    extraUpFlags = [
      "--ssh"
      "--accept-dns"
      "--accept-routes"
    ];
  };

  environment.systemPackages = [ pkgs.tailscale ];
}
