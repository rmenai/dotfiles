{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    devenv
    direnv
    shellharden
    bash-language-server
    lua-language-server
    nixd
  ];

  persist = {
    home = {
      ".cache/pre-commit" = lib.mkDefault true;
      ".cache/lua-language-server" = lib.mkDefault true;
    };
  };
}
