{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    rustup
  ];

  dotfiles = {
    files = {
      ".config/rust-competitive-helper" = lib.mkDefault "rust-competitive-helper";
    };
  };

  persist = {
    home = {
      ".cargo" = lib.mkDefault true;
      ".rustup" = lib.mkDefault true;
    };
  };
}
