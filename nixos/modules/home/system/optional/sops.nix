{ config, lib, inputs, ... }: {
  options.features.system.sops = {
    enable = lib.mkEnableOption "SOPS secrets management";
  };

  config = lib.mkIf config.features.system.sops.enable {
    sops = let sopsFolder = builtins.toString inputs.secrets;
    in {
      age.keyFile = "/home/${config.spec.user}/.config/sops/age/keys.txt";

      defaultSopsFile = "${sopsFolder}/secrets.yaml";
      validateSopsFiles = false;

      secrets = {
        "keys/${config.spec.user}/nullp/private_key".path =
          "/home/${config.spec.user}/.ssh/id_null";
        "keys/${config.spec.user}/vms/private_key".path =
          "/home/${config.spec.user}/.ssh/id_vms";
        "keys/${config.spec.user}/vms/account_hash" = { };
        "keys/${config.spec.user}/vms/account_password" = { };
        "data" = {
          sopsFile = "${sopsFolder}/files/surfingkeys.js";
          path = "/home/${config.spec.user}/.config/chrome/surfingkeys.js";
        };
      };
    };
  };
}
