{ config, ... }: {
  home.shellAliases = {
    "?" = "gh copilot suggest";
    "??" = "gh copilot explain";
  };

  sops.secrets."secrets/hudson_credentials" = { };

  programs = {
    gh.enable = true;

    git = {
      enable = true;

      settings = {
        user = {
          name = "Rami Menai";
          email = config.private.email;
        };

        init.defaultBranch = "main";
        pull.rebase = true;

        credential = {
          helper = "store --file ${config.sops.secrets."secrets/hudson_credentials".path}";
        };
      };
    };
  };
}
