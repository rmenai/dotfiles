{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.dev.cpp;
in
{
  options.features.apps.dev.cpp = {
    enable = lib.mkEnableOption "C/C++ extra tools";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      clang-tools
      lldb_19
      cpplint
      asmfmt
    ];
  };
}
