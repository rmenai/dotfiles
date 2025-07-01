{pkgs, ...}: {
  home.packages = with pkgs; [
    # androidenv.androidPkgs.platform-tools
    android-studio
    android-studio-tools
    apktool
    jadx
    frida-tools
    ghidra
  ];
}
