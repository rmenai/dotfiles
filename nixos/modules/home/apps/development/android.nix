{ config, lib, pkgs, ... }: {
  options.features.apps.development.android = {
    enable = lib.mkEnableOption "Android development tools";
  };

  config = lib.mkIf config.features.apps.development.android.enable {
    home.packages = with pkgs; [
      # androidenv.androidPkgs.platform-tools
      android-studio
      android-studio-tools
      apktool
      jadx
      frida-tools
      ghidra
    ];
  };
}
