{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.tools.dua;
in
{
  options.features.apps.tools.dua = {
    enable = lib.mkEnableOption "Disk usage tools (dua, dust)";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      dua
      dust
    ];
  };
}
