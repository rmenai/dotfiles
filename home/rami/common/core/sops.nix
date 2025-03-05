{
  inputs,
  lib,
  config,
  hostSpec,
  ...
}: let
  sopsFolder = builtins.toString inputs.nix-secrets;
  homeDir = config.home.homeDirectory;
in {
  sops = {
    age.keyFile = "${homeDir}/.config/sops/age/keys.txt";

    defaultSopsFile = "${sopsFolder}/secrets.yaml";
    validateSopsFiles = false;

    secrets = {
      "private_keys/${hostSpec.username}" = {
        path = "${homeDir}/.ssh/id_null";
      };
      "data" = {
        sopsFile = "${sopsFolder}/files/surfingkeys.js";
        path = "${homeDir}/.config/chrome/surfingkeys.js";
      };
    };
  };

  persist = {
    home = {
      ".config/sops" = lib.mkDefault true;
    };
  };
}
