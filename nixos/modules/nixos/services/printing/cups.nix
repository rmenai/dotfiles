{ config, lib, ... }: {
  options.features.services.printing.cups = {
    enable = lib.mkEnableOption "CUPS printing support";
  };

  config = lib.mkIf config.features.services.printing.cups.enable {
    services.printing.enable = true;
    users.users.${config.spec.user}.extraGroups = [ "scanner" "lp" ];
  };
}
