{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.services.waydroid;
in
{
  options.features.services.waydroid = {
    enable = lib.mkEnableOption "Waydroid Android containers";
  };

  config = lib.mkIf cfg.enable {
    virtualisation.waydroid.enable = true;

    environment.systemPackages = with pkgs; [
      pciutils
      kmod
      davfs2
    ];
  };
}
