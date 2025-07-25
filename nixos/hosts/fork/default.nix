{ func, lib, inputs, ... }: {
  imports = lib.flatten [
    inputs.microvm.nixosModules.host

    (map func.custom.relativeToRoot [ "modules/common" ])
    (map func.custom.relativeToRoot [ "modules/nixos" ])

    ./hardware.nix
    ./networking.nix
    ./variants.nix

    ./app.nix
  ];

  spec = {
    host = "fork";
    timeZone = "Europe/Paris";
    defaultLocale = "en_US.UTF-8";
  };

  deployment = {
    targetHost = "fork";
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

      virtualization.microvm.enable = true;
    };

    apps = {
      core.enable = true;
      oxidise.enable = true;
    };
  };
}
