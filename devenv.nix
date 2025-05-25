{...}: {
  dotenv.disableHint = true;
  difftastic.enable = true;

  git-hooks.hooks = {
    actionlint.enable = true;
    check-added-large-files.enable = true;
    check-json.enable = true;
    check-merge-conflicts.enable = true;
    check-yaml.enable = true;
    commitizen.enable = true;
    end-of-file-fixer.enable = true;
    ripsecrets.enable = true;
    shellcheck.enable = true;
    shellcheck.excludes = [".*zsh.*"];

    # trim-trailing-whitespace.enable = true;
    # typos.enable = true;
  };
}
