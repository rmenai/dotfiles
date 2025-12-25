{
  config,
  inputs,
  lib,
  pkgs,
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
    home.packages = [ pkgs.vivaldi ];

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
  };
}
