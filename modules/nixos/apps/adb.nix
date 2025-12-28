{ config, lib, ... }:
let
  cfg = config.features.apps.adb;
in
{
  options.features.apps.adb = {
    enable = lib.mkEnableOption "Android Debug Bridge (ADB)";
  };

  config = lib.mkIf cfg.enable {
    programs.adb.enable = true;
    nixpkgs.config.android_sdk.accept_license = true;

    users.users.${config.spec.user}.extraGroups = [ "adbusers" ];
  };
}
