{pkgs, ...}: {
  imports = [
    ./linters.nix
    ./debuggers.nix
    ./lsp.nix
  ];

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
    bun
    gnumake
    gcc
  ];
}
