{
  xdg.mimeApps.enable = true;

  xdg.mimeApps.defaultApplications = {
    "text/html" = "brave-browser.desktop";
    "application/xhtml+xml" = "brave-browser.desktop";
    "x-scheme-handler/http" = "brave-browser.desktop";
    "x-scheme-handler/https" = "brave-browser.desktop";
    "x-scheme-handler/about" = "brave-browser.desktop";
    "x-scheme-handler/unknown" = "brave-browser.desktop";
  };

  home = {
    sessionVariables = {
      BROWSER = "brave";
    };
  };
}
