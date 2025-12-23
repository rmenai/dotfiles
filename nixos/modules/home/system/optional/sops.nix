{
  config,
  lib,
  inputs,
  ...
}:
let
  sopsFolder = builtins.toString inputs.secrets;
in
{
  options.features.system.sops = {
    enable = lib.mkEnableOption "SOPS secrets management";
  };

  config = lib.mkIf config.features.system.sops.enable {
    sops = {
      age.keyFile = "/home/${config.spec.user}/.config/sops/age/key.txt";
      defaultSopsFile = "${sopsFolder}/users/${config.spec.user}.yaml";
      validateSopsFiles = true;
    };
  };
}
