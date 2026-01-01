{
  config,
  lib,
  ...
}:
let
  cfg = config.features.apps.socials.discord;
in
{
  options.features.apps.socials.discord = {
    enable = lib.mkEnableOption "Discord chat application";
  };

  config = lib.mkIf cfg.enable {
    programs.vesktop = {
      enable = true;

      settings = {
        appBadge = true;
        discordBranch = "stable";
        hardwareAcceleration = true;
        checkUpdates = false;
        tray = true;
      };

      vencord.settings = {
        autoUpdate = false;
        autoUpdateNotification = false;
        notifyAboutUpdates = false;
      };
    };

    catppuccin.vesktop.enable = true;
  };
}
