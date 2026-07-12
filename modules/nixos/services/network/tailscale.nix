{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.services.tailscale;
  persistFolder = config.spec.persistFolder;
in
with lib;
{
  options.features.services.tailscale = {
    enable = mkEnableOption "Tailscale VPN";
  };

  config = mkIf cfg.enable {
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

    environment.persistence.${persistFolder}.directories = [
      "/var/lib/tailscale"
    ];
  };
}
