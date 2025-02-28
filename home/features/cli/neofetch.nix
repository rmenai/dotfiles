{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.features.cli.neofetch;
in {
  options.features.cli.neofetch.enable = mkEnableOption "Enable neofetch configuration";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      neofetch
    ];
  };
}
