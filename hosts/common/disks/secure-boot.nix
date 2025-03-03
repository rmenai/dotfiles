{
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = [
    pkgs.sbctl # For managing Secure Boot keys
  ];

  # Disabling systemd-boot to use lanzaboote instead
  boot.loader.systemd-boot.enable = lib.mkForce false;

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };

  environment.persistence."/persist/system" = {
    directories = [
      "/var/lib/sbctl"
    ];
  };
}
