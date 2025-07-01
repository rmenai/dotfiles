{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    opam
  ];

  dotfiles = {
    files = {
      ".config/utop" = lib.mkDefault "utop";
    };
  };

  persist = {
    home = {
      ".opam" = lib.mkDefault true;
    };
  };
}
