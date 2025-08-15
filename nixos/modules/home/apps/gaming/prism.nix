{ config, lib, pkgs, ... }: {
  options.features.apps.gaming.prism = {
    enable = lib.mkEnableOption "Prism Minecraft launcher";
  };

  config = lib.mkIf config.features.apps.gaming.prism.enable {
    home.packages = with pkgs; [ prismlauncher ];

    xdg.desktopEntries."org.prismlauncher.PrismLauncher" = {
      name = "Prism Launcher";
      comment = "A custom launcher for Minecraft to multiple installations";
      exec = "gamerun prismlauncher %U";
      icon = "org.prismlauncher.PrismLauncher";
      terminal = false;
      type = "Application";
      categories = [ "Game" "ActionGame" ];
      mimeType = [ "application/zip" "application/x-modrinth-modpack+zip" ];
      startupNotify = true;
    };
  };
}
