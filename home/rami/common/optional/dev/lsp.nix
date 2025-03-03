{pkgs, ...}: {
  home.packages = with pkgs; [
    # opam install ocaml-lsp-server
    # rustup component add rust-analyzer
    bash-language-server
    lua-language-server
    pyright
    nixd
  ];
}
