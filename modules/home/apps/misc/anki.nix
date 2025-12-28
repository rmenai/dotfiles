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
    home.packages = [ pkgs.anki ];
  };
}
