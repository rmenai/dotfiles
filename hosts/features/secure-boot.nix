{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.secure-boot;
in {
  options.features.secure-boot.enable = mkEnableOption "Enable lazamboote";
  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.sbctl # For managing Secure Boot keys
    ];

    # Disabling systemd-boot to use lanzaboote instead
    boot.loader.systemd-boot.enable = lib.mkForce false;

    boot.lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };
  };
}
