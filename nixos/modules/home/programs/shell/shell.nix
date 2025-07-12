{lib, ...}: {
  features.dotfiles = {
    paths = {
      ".profile" = lib.mkDefault "shell/.profile";
    };
  };
}
