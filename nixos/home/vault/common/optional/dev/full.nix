{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    rustup
    luajit
    ocaml
    opam
    dune_3
    ocamlPackages.utop
    luajitPackages.luarocks
    gnumake
    gcc

    lldb_19
    stylua
    cpplint
    alejandra
    asmfmt
    clang-tools
    shellharden
    ocamlPackages.ocamlformat
    # opam install ocaml-lsp-server
    # rustup component add rust-analyzer
  ];

  dotfiles = {
    files = {
      ".config/rust-competitive-helper" = lib.mkDefault "rust-competitive-helper";
      ".config/utop" = lib.mkDefault "utop";
    };
  };

  persist = {
    home = {
      ".cargo" = lib.mkDefault true;
      ".rustup" = lib.mkDefault true;
      ".opam" = lib.mkDefault true;
      # ".cache/js-v8flags" = lib.mkDefault true;
      # ".cache/node-gyp" = lib.mkDefault true;
      # ".cache/luarocks" = lib.mkDefault true;
      # ".cache/dune" = lib.mkDefault true;
    };
  };
}
