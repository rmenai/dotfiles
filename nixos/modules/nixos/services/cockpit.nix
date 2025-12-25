{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.services.cockpit;
in
{
  options.features.services.cockpit = {
    enable = lib.mkEnableOption "Cockpit server managment";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ cockpit ];

    services.cockpit = {
      enable = true;
      port = 9090;
      settings = {
        WebService = {
          AllowUnencrypted = true;
        };
      };
    };
  };
}
