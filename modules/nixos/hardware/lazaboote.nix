{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.hardware.lazaboote;
in
{
  options.features.hardware.lazaboote = {
    enable = lib.mkEnableOption "Lanzaboote Secure Boot";

    pkiBundle = lib.mkOption {
      type = lib.types.str;
      default = "/var/lib/sbctl";
      description = "Path to the PKI bundle for secure boot";
    };

    configurationLimit = lib.mkOption {
      type = lib.types.int;
      default = 16;
      description = "Limit on the number of configurations to keep.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.sbctl ];

    boot = {
      lanzaboote = {
        enable = true;
        pkiBundle = cfg.pkiBundle;
        configurationLimit = cfg.configurationLimit;
      };

      loader = {
        efi.canTouchEfiVariables = true;
        systemd-boot.enable = lib.mkForce false;
      };
    };

    features.core.persistence = {
      directories = [
        cfg.pkiBundle
      ];
    };
  };
}
