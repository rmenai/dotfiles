{
  inputs,
  lib,
  ...
}: let
  sopsFolder = builtins.toString inputs.nix-secrets;
in {
  sops = {
    age.keyFile = "/home/rami/.config/sops/age/keys.txt";

    defaultSopsFile = "${sopsFolder}/secrets.yaml";
    validateSopsFiles = false;

    secrets = {
      "private_keys/rami" = {
        path = "/home/rami/.ssh/id_null";
      };
    };
  };

  persist = {
    home = {
      ".config/sops" = lib.mkDefault true;
    };
  };
}
