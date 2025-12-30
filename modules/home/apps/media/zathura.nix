{ config, lib, ... }:
let
  cfg = config.features.apps.media.zathura;
in
{
  options.features.apps.media.zathura = {
    enable = lib.mkEnableOption "Zathura PDF viewer";
  };

  config = lib.mkIf cfg.enable {
    programs.zathura = {
      enable = true;

      options = {
        adjust-open = "width";
        recolor = false;
        sandbox = "none";
        selection-clipboard = "clipboard";
        statusbar-hide = true;
        statusbar-h-padding = 0;
        statusbar-v-padding = 0;
        page-padding = 0;
        guioptions = "none";
        font = "Iosevka 11";
      };

      mappings = {
        u = "scroll half-up";
        d = "scroll half-down";
        T = "toggle_page_mode";
        J = "scroll full-down";
        K = "scroll full-up";
        r = "reload";
        R = "rotate";
        A = "zoom in";
        D = "zoom out";
        i = "recolor";
        p = "print";
        b = "toggle_statusbar";
      };
    };

    xdg.mimeApps.defaultApplications = {
      "application/pdf" = "org.pwmt.zathura.desktop";
      "application/postscript" = "org.pwmt.zathura.desktop";
      "application/epub+zip" = "org.pwmt.zathura.desktop";
    };

    catppuccin.zathura.enable = true;
  };
}
