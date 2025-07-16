{ func, lib, ... }: {
  imports = lib.flatten [
    (map func.custom.relativeToRoot [ "modules/common" ])
    (map func.custom.relativeToRoot [ "modules/nixos" ])

    ./hardware.nix
    ./networking.nix
  ];

  spec = {
    host = "vm";
    timeZone = "Europe/Paris";
    defaultLocale = "en_US.UTF-8";
  };

  deployment = {
    targetHost = "vm";
    targetUser = "root";
    tags = [ "vps" ];
  };

  features = {
    profiles = { core.enable = true; };
    users = { vault.enable = true; };

    system = {
      nix.enable = true;
      home.enable = true;
      sops.enable = true;
    };

    services = {
      networking = {
        openssh.enable = true;
        tailscale.enable = true;
      };
    };

    apps = {
      core.enable = true;
      oxidise.enable = true;
    };
  };
}
