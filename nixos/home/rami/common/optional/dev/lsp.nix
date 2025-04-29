{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    # opam install ocaml-lsp-server
    # rustup component add rust-analyzer
    bash-language-server
    lua-language-server
    pyright
    nixd
  ];

  persist = {
    home = {
      ".cache/lua-language-server" = lib.mkDefault true;
    };
  };
}
