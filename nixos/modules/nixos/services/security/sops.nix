{ config, inputs, lib, pkgs, ... }:
let
  cfg = config.features.system.sops;
  sopsFolder = builtins.toString inputs.secrets;
in {
  options.features.system.sops = {
    enable = lib.mkEnableOption "sops secrets management";

    validateSopsFiles = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to validate sops files";
    };
  };

  config = lib.mkIf cfg.enable {
    sops = {
      defaultSopsFile = "${sopsFolder}/hosts/${config.spec.host}.yaml";
      validateSopsFiles = cfg.validateSopsFiles;
      gnupg.sshKeyPaths = [ ];

      age = {
        keyFile = "/var/lib/sops/key.txt";
        generateKey = true;
        sshKeyPaths = [ ];
      };
    };

    environment.sessionVariables.SOPS_FOLDER = sopsFolder;
    environment.systemPackages = [ pkgs.sops pkgs.age ];

    fileSystems."/var/lib/sops" =
      lib.mkIf config.features.impermanence.enable { neededForBoot = true; };

    features.persist = {
      directories = { "/var/lib/sops" = lib.mkDefault true; };
    };
  };
}
