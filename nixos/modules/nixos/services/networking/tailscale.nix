{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.features.services.networking.tailscale;
in
with lib;
{
  options.features.services.networking.tailscale = {
    enable = mkEnableOption "Tailscale VPN";

    port = mkOption {
      type = types.port;
      default = 41641;
      example = "8113";
      description = "The port to listen on for tunnel traffic (0=autoselect).";
    };

    routingFeature = mkOption {
      type = types.enum [
        "none"
        "client"
        "server"
        "both"
      ];
      default = "both";
      example = "server";
      description = lib.mdDoc ''
        Enables settings required for Tailscale's routing features like subnet routers and exit nodes.

        To use these features, you will still need to call `sudo tailscale up` with the relevant flags like `--advertise-exit-node` and `--exit-node`.

        When set to `client` or `both`, reverse path filtering will be set to loose instead of strict.
        When set to `server` or `both`, IP forwarding will be enabled.
      '';
    };

    autoprovision = {
      enable = mkEnableOption "enable auto provisioning" // {
        default = true;
      };
      options = mkOption {
        type = types.listOf types.str;
        default = [
          "--ssh"
          "--accept-dns"
          "--accept-routes"
        ];
        example = [ "--advertise-exit-node" ];
        description = "Options to pass to Tailscale";
      };
    };
  };

  config = mkIf cfg.enable {
    sops.secrets."secrets/tailscale_auth_key" = {
      restartUnits = [ "tailscaled-autoconnect.service" ];
    };

    services.tailscale = {
      enable = true;
      authKeyFile =
        lib.mkIf cfg.autoprovision.enable
          config.sops.secrets."secrets/tailscale_auth_key".path;
      useRoutingFeatures = cfg.routingFeature;
      port = cfg.port;
      extraUpFlags = cfg.autoprovision.options;
    };

    environment.systemPackages = [ pkgs.tailscale ];

    features.persist = {
      directories = {
        "/var/lib/tailscale" = true;
      };
    };
  };
}
