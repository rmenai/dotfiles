{lib, ...}: {
  dotfiles = {
    files = {
      ".profile" = lib.mkDefault "shell/.profile";
    };
  };
}
