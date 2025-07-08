{pkgs, ...}: {
  imports = [
    ./ide.nix
    ./godot.nix
    ./android.nix
    ./node.nix
    ./ocaml.nix
    ./python.nix
    ./rust.nix
    ./latex.nix
    ./ai.nix
    ./r.nix
  ];

  home.packages = with pkgs; [
    devenv
    direnv
    jc

    dua
    hyperfine
    dust

    gcc
    gnumake
    mold

    luajit
    clang-tools
    nixd
    shellharden
    markdownlint-cli
    lldb_19
    stylua
    cpplint
    alejandra
    asmfmt
  ];
}
