{pkgs, ...}: {
  home.packages = with pkgs; [
    python314
    nodejs_23
    rustup
    
    ocaml
    ocamlPackages.utop
    ocamlPackages.lsp

    luajit
    luajitPackages.luarocks
  ];
}
