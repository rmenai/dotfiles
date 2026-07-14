{
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
}
