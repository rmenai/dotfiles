{pkgs, ...}: {
  home.packages = with pkgs; [
    python314
    nodejs_23
    rustup
    luajit
    ocaml
    opam
    dune_3

    ocamlPackages.utop
    luajitPackages.luarocks
    bash-language-server
    lua-language-server
    pyright
    nixd

    stylua
    cpplint
    alejandra
    asmfmt
    black
    isort
    clang-tools
    shellharden

    # opam install ocaml-lsp-server
    # rustup component add rust-analyzer
  ];
}
