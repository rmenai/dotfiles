{ config, inputs, lib, pkgs, ... }:
let
  cfg = config.features.services.security.sops;
  sopsFolder = builtins.toString inputs.secrets;
in {
  options.features.services.security.sops = {
    enable = lib.mkEnableOption "sops secrets management";

    defaultSopsFile = lib.mkOption {
      type = lib.types.str;
      default = "${sopsFolder}/secrets.yaml";
      description = "Default sops file to use";
    };

    validateSopsFiles = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to validate sops files";
    };
  };

  config = lib.mkIf cfg.enable {
    sops = {
      defaultSopsFile = cfg.defaultSopsFile;
      validateSopsFiles = cfg.validateSopsFiles;

      age = {
        sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
        keyFile = "/var/lib/sops-nix/key.txt";
        generateKey = true;
      };
    };

    environment.sessionVariables.SOPS_FOLDER = sopsFolder;
    environment.systemPackages = [ pkgs.sops ];

    fileSystems."/var/lib/sops-nix".neededForBoot = true;
    fileSystems."/etc/ssh".neededForBoot = true;

    features.persist = {
      directories = { "/var/lib/sops-nix" = lib.mkDefault true; };
    };
  };
}
