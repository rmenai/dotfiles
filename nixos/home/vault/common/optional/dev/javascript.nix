{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    nodejs_23
    bun

    vue-language-server
    typescript-language-server
    tailwindcss-language-server
    eslint
  ];

  persist = {
    home = {
      ".cache/node-gyp" = lib.mkDefault true;
    };
  };
}
