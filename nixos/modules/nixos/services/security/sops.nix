{ config, inputs, lib, pkgs, ... }:
let
  cfg = config.features.services.security.sops;
  sopsFolder = builtins.toString inputs.secrets;
in {
  options.features.services.security.sops = {
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

      age = {
        keyFile = "/var/lib/sops/key.txt";
        generateKey = true;
      };

      secrets."users/vault/age_key" = {
        path = "/home/${config.spec.user}/.config/sops/age/key.txt";
        owner = config.spec.user;
        group = "users";
        mode = "0600";
      };
    };

    systemd.tmpfiles.rules = [
      "d /home/${config.spec.user}/.config 0755 ${config.spec.user} users -"
      "d /home/${config.spec.user}/.config/sops 0755 ${config.spec.user} users -"
      "d /home/${config.spec.user}/.config/sops/age 0755 ${config.spec.user} users -"
    ];

    environment.sessionVariables.SOPS_FOLDER = sopsFolder;
    environment.systemPackages = [ pkgs.sops ];

    fileSystems."/var/lib/sops".neededForBoot = true;

    features.persist = {
      directories = { "/var/lib/sops" = lib.mkDefault true; };
    };
  };
}
