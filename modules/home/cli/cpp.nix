{ pkgs, ... }: {
  home.packages = with pkgs; [
    clang-tools
    lldb_19
    cpplint
    asmfmt
  ];
}
