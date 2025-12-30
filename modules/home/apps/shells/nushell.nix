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
        settings = {
          jobs.disabled = true; # To avoid showing atuin job

          character = {
            success_symbol = "[➜](bold green)";
            error_symbol = "[➜](bold red)";
          };
        };
      };

      nushell = {
        enable = true;
        configFile.source = ./config.nu;

        extraEnv = ''
          # Use starship indicator instead

          $env.PROMPT_INDICATOR = ""
          $env.PROMPT_INDICATOR_VI_INSERT = ""
          $env.PROMPT_INDICATOR_VI_NORMAL = ""
          $env.PROMPT_MULTILINE_INDICATOR = "::: "
        '';
      };
    };

    catppuccin = {
      nushell.enable = true;
      starship.enable = true;
    };
  };
}
