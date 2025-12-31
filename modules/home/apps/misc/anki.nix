{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.misc.anki;
in
{
  options.features.apps.misc.anki = {
    enable = lib.mkEnableOption "Anki flashcards app";
  };

  config = lib.mkIf cfg.enable {
    # TODO: use home-manager module for Anki
    home.packages = [ pkgs.anki ];
    catppuccin.anki.enable = true;

    xdg.mimeApps.defaultApplications = {
      "application/vnd.anki" = "anki.desktop";
      "application/x-apkg" = "anki.desktop";
      "application/x-anki" = "anki.desktop";
      "application/x-anki-addon" = "anki.desktop";
    };
  };
}
