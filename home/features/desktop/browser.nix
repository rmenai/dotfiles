{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.desktop.browser;
in {
  options.features.desktop.browser.enable = mkEnableOption "Install zen browser";
  config = mkIf cfg.enable {
    home.packages = [
      (import ../../../pkgs/zen.nix {
        appimageTools = pkgs.appimageTools;
        fetchurl = pkgs.fetchurl;
      })
    ];
  };
}
