{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    android-tools
  ];

  nixpkgs.config.android_sdk.accept_license = true;
}
