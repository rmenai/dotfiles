{ config, lib, ... }: {
  options.features.apps.adb = {
    enable = lib.mkEnableOption "Android Debug Bridge (ADB)";
  };

  config = lib.mkIf config.features.apps.adb.enable {
    programs.adb.enable = true;
    nixpkgs.config.android_sdk.accept_license = true;

    users.users.${config.spec.user}.extraGroups = [ "adbusers" ];
  };
}
