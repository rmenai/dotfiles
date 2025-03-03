{pkgs, ...}: {
  home.packages = with pkgs; [
    python312Packages.debugpy
    lldb_19
  ];
}
