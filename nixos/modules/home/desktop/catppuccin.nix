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
      accent = "pink";

      cursors.enable = true;
      cursors.accent = "dark";
    };

    qt = {
      enable = true;
      style.name = "kvantum";
      platformTheme.name = "kvantum";
    };

    gtk = {
      enable = true;
      font.name = "Inter:medium";
      theme.name = "adw-gtk3-dark";
      theme.package = pkgs.adw-gtk3;
    };
  };
}
