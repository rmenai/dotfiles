{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    rustup
  ];

  features.dotfiles = {
    paths = {
      ".config/rust-competitive-helper" = lib.mkDefault "rust-competitive-helper";
      ".config/bacon" = lib.mkDefault "bacon";
    };
  };

  features.persist = {
    directories = {
      ".cargo" = lib.mkDefault true;
      ".rustup" = lib.mkDefault true;
    };
  };
}
