{
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
          name = "Rami Menai";
          email = "rami@menai.me";
        };

        init.defaultBranch = "main";
        pull.rebase = true;
      };
    };
  };
}
