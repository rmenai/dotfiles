{
  home.shellAliases = {
    a = "atuin";
    ast = "atuin stats";
    asr = "atuin scripts run";
    asn = "atuin scripts new";
    asd = "atuin scripts delete";
    asl = "atuin scripts list";
  };

  programs.atuin = {
    enable = true;
    enableNushellIntegration = true;

    settings = {
      auto_sync = true;
      sync_frequency = "1h";
      style = "compact";
      inline_height = 20;
      enter_accept = true;
    };
  };

  catppuccin.atuin.enable = true;
}
