{
  inputs,
  lib,
  config,
  ...
}: let
  sopsFolder = builtins.toString inputs.nix-secrets;
in {
  imports = [inputs.sops-nix.homeManagerModules.sops];

  sops = {
    age.keyFile = "${config.hostSpec.home}/.config/sops/age/keys.txt";

    defaultSopsFile = "${sopsFolder}/secrets.yaml";
    validateSopsFiles = false;

    secrets = {
      "keys/${config.hostSpec.username}/nullp/private_key" = {
        path = "${config.hostSpec.home}/.ssh/id_null";
      };
      "keys/${config.hostSpec.username}/vms/private_key" = {
        path = "${config.hostSpec.home}/.ssh/id_vms";
      };
      "data" = {
        sopsFile = "${sopsFolder}/files/surfingkeys.js";
        path = "${config.hostSpec.home}/.config/chrome/surfingkeys.js";
      };
    };
  };

  persist = {
    home = {
      ".config/sops" = lib.mkDefault true;
    };
  };
}
