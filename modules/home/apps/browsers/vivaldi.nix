{
  config,
  inputs,
  lib,
  ...
}:
let
  cfg = config.features.apps.browsers.vivaldi;
in
{
  options.features.apps.browsers.vivaldi = {
    enable = lib.mkEnableOption "Vivaldi browser";
  };

  config = lib.mkIf cfg.enable {
    programs.vivaldi.enable = true;

    sops.secrets."data" = {
      sopsFile = "${builtins.toString inputs.secrets}/files/surfingkeys.js";
      path = "/home/${config.spec.user}/.config/vivaldi/surfingkeys.js";
    };

    xdg.mimeApps.defaultApplications = {
      "text/html" = "vivaldi-stable.desktop";
      "x-scheme-handler/http" = "vivaldi-stable.desktop";
      "x-scheme-handler/https" = "vivaldi-stable.desktop";
      "x-scheme-handler/about" = "vivaldi-stable.desktop";
      "x-scheme-handler/unknown" = "vivaldi-stable.desktop";
    };

    catppuccin.vivaldi.enable = true;
  };
}
