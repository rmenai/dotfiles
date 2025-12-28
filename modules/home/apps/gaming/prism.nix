{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.gaming.prism;
in
{
  options.features.apps.gaming.prism = {
    enable = lib.mkEnableOption "Prism Minecraft launcher";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.prismlauncher ];

    # xdg.desktopEntries."org.prismlauncher.PrismLauncher" = {
    #   name = "Prism Launcher";
    #   comment = "A custom launcher for Minecraft to multiple installations";
    #   exec = "gamerun prismlauncher %U";
    #   icon = "org.prismlauncher.PrismLauncher";
    #   terminal = false;
    #   type = "Application";
    #   categories = [
    #     "Game"
    #     "ActionGame"
    #   ];
    #   mimeType = [
    #     "application/zip"
    #     "application/x-modrinth-modpack+zip"
    #   ];
    #   startupNotify = true;
    # };
  };
}
