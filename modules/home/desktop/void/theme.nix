{ pkgs, ... }:
{
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

    gtk4.theme = null;

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

  home.pointerCursor.enable = true;
}
