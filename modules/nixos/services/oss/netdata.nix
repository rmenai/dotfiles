{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.services.netdata;
in
{
  options.features.services.netdata = {
    enable = lib.mkEnableOption "Netdata configuration";
  };

  config = lib.mkIf cfg.enable {
    services.netdata = {
      enable = true;
      package = pkgs.netdata.override { withCloudUi = true; };
    };
  };
}
