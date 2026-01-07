{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.core.sops;
  secrets = builtins.toString inputs.secrets;
in
{
  options.features.core.sops = {
    enable = lib.mkEnableOption "sops secrets management";

    sopsFolder = lib.mkOption {
      type = lib.types.str;
      default = "/var/lib/sops";
      description = "Path to the PKI bundle for secure boot";
    };
  };

  config = lib.mkIf cfg.enable {
    environment = {
      sessionVariables.SOPS_FOLDER = secrets;
      systemPackages = [
        pkgs.sops
        pkgs.age
      ];
    };

    sops = {
      defaultSopsFile = "${secrets}/hosts/${config.spec.host}.yaml";
      validateSopsFiles = true;

      gnupg.sshKeyPaths = [ ];

      age = {
        keyFile = "${cfg.sopsFolder}/key.txt";
        generateKey = false;
        sshKeyPaths = [ ];
      };
    };

    features.core.persistence = {
      directories = [
        "${cfg.sopsFolder}"
      ];
    };

    fileSystems."${cfg.sopsFolder}" = lib.mkIf config.features.core.persistence.enable {
      neededForBoot = true;
      device = "${config.spec.persistFolder}${cfg.sopsFolder}";
      options = [ "bind" ];
    };
  };
}
