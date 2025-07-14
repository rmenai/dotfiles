{ config, lib, pkgs, ... }:

let cfg = config.features.services.networking.tailscale;
in with lib; {
  options.features.services.networking.tailscale = {
    enable = mkEnableOption "Tailscale VPN";

    port = mkOption {
      type = types.port;
      default = 41641;
      example = "8113";
      description = "The port to listen on for tunnel traffic (0=autoselect).";
    };

    routingFeature = mkOption {
      type = types.enum [ "none" "client" "server" "both" ];
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
      enable = mkEnableOption "enable auto provisioning" // { default = true; };
      options = mkOption {
        type = types.listOf types.str;
        default = [
          "--ssh"
          "--accept-dns"
          "--accept-routes"
          "--advertise-connector"
          "--advertise-exit-node"
        ];
        example = [ "--advertise-exit-node" ];
        description = "Options to pass to Tailscale";
      };
    };
  };

  config = mkIf cfg.enable {
    sops.secrets."secrets/tailscale_auth_key" = {
      restartUnits = [ "tailscale-autoconnect.service" ];
    };

    services.tailscale = {
      enable = true;
      useRoutingFeatures = cfg.routingFeature;
      port = cfg.port;
    };

    environment.systemPackages = [ pkgs.tailscale ];

    networking.firewall = {
      enable = true;
      allowedUDPPorts = [ cfg.port ];
      trustedInterfaces = [ "tailscale0" ];
    };

    features.persist = { directories = { "/var/lib/tailscale" = true; }; };

    # Auto-provisioning service
    systemd.services.tailscale-autoconnect = mkIf cfg.autoprovision.enable {
      description = "Automatic connection to Tailscale";

      after = [ "network-pre.target" "tailscale.service" ];
      wants = [ "network-pre.target" "tailscale.service" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig.Type = "oneshot";

      script = ''
        #!/usr/bin/env bash

        # Wait for tailscaled to settle
        sleep 2

        # Check if we are already authenticated to tailscale
        status="$(${pkgs.tailscale}/bin/tailscale status -json | ${pkgs.jq}/bin/jq -r .BackendState)"
        if [ $status = "Running" ]; then # if so, then do nothing
          exit 0
        fi

        # Otherwise authenticate with tailscale
        ${pkgs.tailscale}/bin/tailscale up --auth-key file:${
          config.sops.secrets."secrets/tailscale_auth_key".path
        } ${lib.concatStringsSep " " cfg.autoprovision.options}
      '';
    };
  };
}
