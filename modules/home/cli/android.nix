{ pkgs, ... }: {
  home.packages = [
    # androidenv.androidPkgs.platform-tools
    pkgs.stable.android-studio
    pkgs.stable.android-studio-tools
    pkgs.apktool
    pkgs.jadx
  ];
}
