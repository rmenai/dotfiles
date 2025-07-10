{pkgs, ...}: {
  imports = [
    ./containers
  ];

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
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  features.persist = {
    directories = {
      "/var/lib/containers" = true;
    };
  };

  environment.systemPackages = with pkgs; [
    podman-compose
    podman-tui
    distrobox
  ];
}
