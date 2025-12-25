{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.dev.android;
in
{
  options.features.apps.dev.android = {
    enable = lib.mkEnableOption "Android development tools";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      # androidenv.androidPkgs.platform-tools
      pkgs.stable.android-studio
      pkgs.stable.android-studio-tools
      pkgs.apktool
      pkgs.jadx
    ];
  };
}
