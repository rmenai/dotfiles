{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.features.services.networking.cockpit = {
    enable = lib.mkEnableOption "Cockpit server managment";
  };

  config = lib.mkIf config.features.services.networking.cockpit.enable {
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
