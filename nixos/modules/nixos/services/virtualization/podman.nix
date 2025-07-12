{ config, lib, pkgs, ... }: {
  options.features.services.virtualization.podman = {
    enable = lib.mkEnableOption "Podman container runtime";
  };

  config = lib.mkIf config.features.services.virtualization.podman.enable {
    virtualisation = {
      podman = {
        enable = true;
        dockerCompat = true;
        dockerSocket.enable = true;
        autoPrune = {
          enable = true;
          dates = "weekly";
          flags = [ "--filter=until=24h" "--filter=label!=important" ];
        };
        defaultNetwork.settings.dns_enabled = true;
      };
    };

    users.users.${config.spec.user}.extraGroups = [ "docker" "podman" ];

    environment.systemPackages = with pkgs; [
      podman-compose
      podman-tui
      distrobox
    ];

    features.persist = { directories = { "/var/lib/containers" = true; }; };
  };
}
