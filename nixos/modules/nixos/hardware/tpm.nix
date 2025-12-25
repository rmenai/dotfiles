{ config, lib, ... }:
let
  cfg = config.features.hardware.tpm;
in
{
  options.features.hardware.tpm = {
    enable = lib.mkEnableOption "TPM 2.0 support";
  };

  config = lib.mkIf cfg.enable {
    security.tpm2 = {
      enable = true;
      pkcs11.enable = true;
      tctiEnvironment.enable = true;
    };

    users.users.${config.spec.user}.extraGroups = [ "tss" ];
  };
}
