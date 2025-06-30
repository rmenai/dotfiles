{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    bun
    eslint
  ];

  persist = {
    home = {
      # ".cache/node-gyp" = lib.mkDefault true;
    };
  };
}
