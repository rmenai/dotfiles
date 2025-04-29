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
      "private_keys/${config.hostSpec.username}" = {
        path = "${config.hostSpec.home}/.ssh/id_null";
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
