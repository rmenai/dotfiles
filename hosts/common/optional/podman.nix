{pkgs, ...}: {
  imports = [
    ./containers
  ];

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
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

  environment.persistence."/persist/system" = {
    directories = [
      "/var/lib/containers"
    ];
  };

  environment.systemPackages = with pkgs; [
    podman-compose
  ];
}
