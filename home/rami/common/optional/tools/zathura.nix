{lib, ...}: {
  dotfiles = {
    files = {
      ".config/zathura" = lib.mkDefault "zathura";
    };
  };
}
