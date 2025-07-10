{
  inputs,
  config,
  ...
}: let
  sopsFolder = builtins.toString inputs.nix-secrets;
in {
  imports = [inputs.sops-nix.homeManagerModules.sops];

  sops = {
    age.keyFile = "${config.spec.home}/.config/sops/age/keys.txt";

    defaultSopsFile = "${sopsFolder}/secrets.yaml";
    validateSopsFiles = false;

    secrets = {
      "keys/${config.spec.username}/nullp/private_key".path = "${config.spec.home}/.ssh/id_null";
      "keys/${config.spec.username}/vms/private_key".path = "${config.spec.home}/.ssh/id_vms";
      "keys/${config.spec.username}/vms/account_hash" = {};
      "keys/${config.spec.username}/vms/account_password" = {};
      "data" = {
        sopsFile = "${sopsFolder}/files/surfingkeys.js";
        path = "${config.spec.home}/.config/chrome/surfingkeys.js";
      };
    };
  };
}
