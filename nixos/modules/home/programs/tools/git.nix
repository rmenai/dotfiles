{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    git
    gh
  ];

  features.dotfiles = {
    paths = {
      ".config/git" = lib.mkDefault "git";
    };
  };
}
