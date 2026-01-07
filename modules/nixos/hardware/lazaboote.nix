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
      description = "Path to the PKI bundle for secure boot";
    };

    configurationLimit = lib.mkOption {
      type = lib.types.int;
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
        "${cfg.pkiBundle}"
      ];
    };

    fileSystems.${cfg.pkiBundle} = lib.mkIf config.features.core.persistence.enable {
      neededForBoot = true;
      device = "${config.spec.persistFolder}${cfg.pkiBundle}";
      options = [ "bind" ];
    };
  };
}
