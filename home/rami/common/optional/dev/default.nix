{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./linters.nix
    ./debuggers.nix
    ./lsp.nix
  ];

  home.packages = with pkgs; [
    devenv
    direnv
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
      ".cache/pip" = lib.mkDefault true;
      ".cache/js-v8flags" = lib.mkDefault true;
      ".cache/node-gyp" = lib.mkDefault true;
      ".cache/luarocks" = lib.mkDefault true;
      ".cache/dune" = lib.mkDefault true;
      ".cache/pypoetry" = lib.mkDefault true;
      ".cache/pre-commit" = lib.mkDefault true;
    };
  };
}
