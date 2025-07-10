{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    zathura
  ];

  xdg.mimeApps.defaultApplications = {
    "application/pdf" = "org.pwmt.zathura-pdf-mupdf.desktop";
    "application/x-pdf" = "org.pwmt.zathura-pdf-mupdf.desktop";
  };

  features.dotfiles = {
    paths = {
      ".config/zathura" = lib.mkDefault "zathura";
    };
  };
}
