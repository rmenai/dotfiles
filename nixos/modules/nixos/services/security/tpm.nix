{ config, lib, ... }: {
  options.features.services.security.tpm = {
    enable = lib.mkEnableOption "TPM 2.0 support";
  };

  config = lib.mkIf config.features.services.security.tpm.enable {
    security.tpm2.enable = true;
    security.tpm2.pkcs11.enable = true;
    security.tpm2.tctiEnvironment.enable = true;

    users.users.${config.spec.user}.extraGroups = [ "tss" ];
  };
}
