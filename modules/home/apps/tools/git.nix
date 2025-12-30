{ config, lib, ... }:
let
  cfg = config.features.apps.tools.git;
in
{
  options.features.apps.tools.git = {
    enable = lib.mkEnableOption "Git tools";
  };

  config = lib.mkIf cfg.enable {
    home.shellAliases = {
      "?" = "gh copilot suggest";
      "??" = "gh copilot explain";
    };

    programs = {
      gh.enable = true;

      git = {
        enable = true;

        settings = {
          user = {
            name = config.spec.userFullName;
            email = config.spec.email;
          };

          init.defaultBranch = "main";
          pull.rebase = true;
        };
      };
    };
  };
}
