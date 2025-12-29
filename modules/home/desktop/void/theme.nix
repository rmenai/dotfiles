{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.desktop.void;
in
{
  config = lib.mkIf cfg.enable {
    catppuccin = {
      flavor = "mocha";
      accent = "lavender";

      cursors = {
        enable = true;
        accent = "dark";
      };

      kvantum.enable = true;
      gtk.icon.enable = true;
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
