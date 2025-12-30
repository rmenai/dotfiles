{
  config,
  lib,
  ...
}:
let
  cfg = config.features.apps.shells.nushell;
in
{
  options.features.apps.shells.nushell = {
    enable = lib.mkEnableOption "Nushell shell";
  };

  config = lib.mkIf cfg.enable {
    programs = {
      carapace = {
        enable = true;
        enableNushellIntegration = true;
      };

      starship = {
        enable = true;
        enableNushellIntegration = true;
      };

      nushell = {
        enable = true;
        configFile.source = ./config.nu;
      };
    };

    catppuccin = {
      nushell.enable = true;
      starship.enable = true;
    };
  };
}
