{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.features.desktop.catppuccin;
in
{
  options.features.desktop.catppuccin = {
    enable = lib.mkEnableOption "Catppuccin theme globally";
  };

  config = lib.mkIf cfg.enable {
    catppuccin = {
      enable = true;
      flavor = "mocha";
      accent = "lavender";

      cursors.enable = true;
      cursors.accent = "dark";
    };

    gtk = {
      enable = true;

      theme = {
        name = "catppuccin-mocha-lavender-standard";
        package = pkgs.catppuccin-gtk.override {
          accents = [ "lavender" ];
          size = "standard";
          variant = "mocha";
        };
      };
    };

    qt = {
      enable = true;
      platformTheme.name = "kvantum";
      style.name = "kvantum";
    };
  };
}
