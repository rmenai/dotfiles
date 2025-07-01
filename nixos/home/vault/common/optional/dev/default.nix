{pkgs, ...}: {
  imports = [
    ./ide.nix
    ./godot.nix
    ./android.nix
    ./node.nix
    ./ocaml.nix
    ./python.nix
    ./rust.nix
  ];

  home.packages = with pkgs; [
    devenv
    direnv
    gnumake
    gcc
    luajit
    nixd

    # shellharden
    # bash-language-server
    # lua-language-server
    # markdownlint-cli
    # typst
    # tinymist
    # typstyle
    # texlab
    # lldb_19
    # stylua
    # cpplint
    # alejandra
    # asmfmt
    # clang-tools
    # mold
  ];
}
