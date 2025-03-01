{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.features.printer;
in {
  options.features.printer.enable = mkEnableOption "Enable printer";
  config = mkIf cfg.enable {
    services.printing.enable = true;
  };
}
