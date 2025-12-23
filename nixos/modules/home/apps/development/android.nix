{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.features.apps.development.android = {
    enable = lib.mkEnableOption "Android development tools";
  };

  config = lib.mkIf config.features.apps.development.android.enable {
    home.packages = [
      # androidenv.androidPkgs.platform-tools
      pkgs.stable.android-studio
      pkgs.stable.android-studio-tools
      pkgs.apktool
      pkgs.jadx
      pkgs.frida-tools
      pkgs.ghidra
    ];
  };
}
