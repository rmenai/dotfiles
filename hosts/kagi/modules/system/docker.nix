{ pkgs, ... }: {
  virtualisation = {
    containers.enable = true;
    oci-containers.backend = "podman";
    podman = {
      enable = true;
      autoPrune.enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true; # Required for containers under podman-compose to be able to talk to each other.
    };

    containers.storage.settings = {
      storage = {
        driver = "btrfs";
        runroot = "/run/containers/storage";
        graphroot = "/var/lib/containers/storage";
        options.overlay.mountopt = "nodev,metacopy=on";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    podman
    podman-tui
    docker-compose # v2 specification for dockge support
  ];

  systemd.services.podman-autostart = {
    description = "Start Podman containers with restart policies";
    after = [
      "network-online.target"
      "podman.socket"
    ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.podman}/bin/podman start --all --filter restart-policy=always --filter restart-policy=unless-stopped";
    };
  };
}
