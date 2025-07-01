{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    fnm
  ];

  persist = {
    home = {
      ".bun" = lib.mkDefault true;
    };
  };
}
