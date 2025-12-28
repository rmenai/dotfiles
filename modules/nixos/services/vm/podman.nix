{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.services.podman;
in
{
  options.features.services.podman = {
    enable = lib.mkEnableOption "Podman container runtime";
  };

  config = lib.mkIf cfg.enable {
    virtualisation = {
      podman = {
        enable = true;
        dockerCompat = true;
        dockerSocket.enable = true;
        autoPrune = {
          enable = true;
          dates = "weekly";
          flags = [
            "--filter=until=24h"
            "--filter=label!=important"
          ];
        };
      };

      oci-containers.backend = "podman";
    };

    users.users.${config.spec.user}.extraGroups = [
      "docker"
      "podman"
    ];

    environment.systemPackages = with pkgs; [
      podman-compose
      podman-tui
    ];
  };
}
