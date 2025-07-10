{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    opam
  ];

  features.dotfiles = {
    paths = {
      ".config/utop" = lib.mkDefault "utop";
    };
  };

  features.persist = {
    directories = {
      ".opam" = lib.mkDefault true;
    };
  };
}
