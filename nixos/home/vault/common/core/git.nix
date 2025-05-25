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

  persist = {
    home = {
      ".config/gh" = lib.mkDefault true;
      ".cache/gh" = lib.mkDefault true;
      ".local/share/gh" = lib.mkDefault true;
      ".cache/gitstatus" = lib.mkDefault true;
    };
  };
}
