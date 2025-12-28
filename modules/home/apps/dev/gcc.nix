{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.dev.gcc;
in
{
  options.features.apps.dev.gcc = {
    enable = lib.mkEnableOption "Base build tools";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      gcc
      gdb
      gnumake
      cmake
    ];
  };
}
