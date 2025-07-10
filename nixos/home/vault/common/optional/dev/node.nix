{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    fnm
  ];

  features.persist = {
    directories = {
      ".bun" = lib.mkDefault true;
    };
  };
}
