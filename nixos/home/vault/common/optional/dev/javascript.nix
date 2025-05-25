{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    nodejs_23
    bun
    eslint
  ];

  persist = {
    home = {
      ".cache/node-gyp" = lib.mkDefault true;
    };
  };
}
