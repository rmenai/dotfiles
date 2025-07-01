{pkgs, ...}: {
  home.packages = with pkgs; [
    jetbrains.pycharm-professional
    jetbrains.rust-rover
    jetbrains.rider
    jetbrains.clion
    jetbrains.webstorm
    jetbrains.datagrip

    android-studio
    android-studio-tools
    androidenv.androidPkgs.platform-tools
    apktool
    jadx
    frida-tools
    ghidra

    android-file-transfer
    heimdall
  ];
}
