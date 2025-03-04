{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    git
    gh
  ];

  dotfiles = {
    files = {
      ".config/git" = lib.mkDefault "git";
    };
  };
}
