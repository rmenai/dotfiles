{ config, lib, ... }:
let
  cfg = config.features.services.cups;
in
{
  options.features.services.cups = {
    enable = lib.mkEnableOption "CUPS printing support";
  };

  config = lib.mkIf cfg.enable {
    services.printing.enable = true;
    users.users.${config.spec.user}.extraGroups = [
      "scanner"
      "lp"
    ];
  };
}
