{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.tools.zip;
in
{
  options.features.apps.tools.zip = {
    enable = lib.mkEnableOption "Compression tools (zip, unzip)";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      unzip
      zip
    ];
  };
}
