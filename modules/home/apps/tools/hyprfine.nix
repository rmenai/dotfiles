{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.tools.hyprfine;
in
{
  options.features.apps.tools.hyprfine.enable =
    lib.mkEnableOption "Benchmarking tools (hyperfine, tokei)";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      hyperfine
      tokei
    ];
  };
}
