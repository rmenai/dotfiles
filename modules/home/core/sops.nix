{
  config,
  inputs,
  lib,
  ...
}:
let
  cfg = config.features.core.sops;
  secrets = builtins.toString inputs.secrets;
in
{
  options.features.core.sops = {
    enable = lib.mkEnableOption "SOPS secrets management";
  };

  config = lib.mkIf cfg.enable {
    sops = {
      age.keyFile = "/home/${config.spec.user}/.config/sops/age/key.txt";
      defaultSopsFile = "${secrets}/users/${config.spec.user}.yaml";
      validateSopsFiles = true;
    };
  };
}
