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
    markdownlint-cli
    nodejs_22
    typst
    tinymist
    typstyle
    texlab
    nixd
    aoc-cli
    godot
    mold
  ];

  persist = {
    home = {
      # ".cache/pre-commit" = lib.mkDefault true;
      # ".cache/lua-language-server" = lib.mkDefault true;
      # ".config/github-copilot" = lib.mkDefault true;
      # ".local/share/devenv" = lib.mkDefault true;
      ".bun" = lib.mkDefault true;
    };
  };
}
