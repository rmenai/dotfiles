{ config, lib, ... }:
let
  cfg = config.features.apps.browsers.brave;
in
{
  options.features.apps.browsers.brave = {
    enable = lib.mkEnableOption "Brave browser";
  };

  config = lib.mkIf cfg.enable {
    programs.brave.enable = true;
    catppuccin.brave.enable = true;

    xdg.mimeApps.defaultApplications = {
      "text/html" = "brave-browser.desktop";
      "x-scheme-handler/http" = "brave-browser.desktop";
      "x-scheme-handler/https" = "brave-browser.desktop";
      "x-scheme-handler/about" = "brave-browser.desktop";
      "x-scheme-handler/unknown" = "brave-browser.desktop";
    };
  };
}
