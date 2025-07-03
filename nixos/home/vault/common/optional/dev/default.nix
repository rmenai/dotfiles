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
  ];

  home.packages = with pkgs; [
    devenv
    direnv

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
