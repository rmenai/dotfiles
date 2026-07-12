{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.adb;
in
{
  options.features.apps.adb = {
    enable = lib.mkEnableOption "Android Debug Bridge (ADB)";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      android-tools
    ];

    nixpkgs.config.android_sdk.accept_license = true;

    users.users.${config.spec.user}.extraGroups = [ "adbusers" ];
  };
}
