{pkgs, ...}: let
  wezterm-nvim-launcher = pkgs.writeShellScriptBin "wezterm-nvim-launcher" ''
    #!/bin/sh
    FILE_PATH="$1"
    DIR_PATH=$(dirname "$FILE_PATH")
    CMD="cd \"$DIR_PATH\" && nvim \"$FILE_PATH\""
    ${pkgs.wezterm}/bin/wezterm cli spawn -- zsh -l -i -c "$CMD"
  '';
in {
  xdg.enable = true;
  xdg.mimeApps.enable = true;

  xdg.desktopEntries."nvim-wezterm" = {
    name = "Neovim (WezTerm)";
    comment = "Edit file with Neovim inside the WezTerm terminal";
    exec = "${wezterm-nvim-launcher}/bin/wezterm-nvim-launcher %f";
    terminal = false;
    icon = "utilities-terminal";

    mimeType = [
      "text/plain"
      "text/x-python"
      "text/x-shellscript"
      "application/x-shellscript"
      "text/javascript"
      "application/javascript"
      "text/css"
      "text/html"
      "text/rust"
      "application/json"
      "application/xml"
      "application/yaml"

      "text/x-csrc"
      "text/x-chdr"
      "text/x-c++src"
      "text/x-c++hdr"
      "text/x-ocaml"
    ];
  };

  xdg.mimeApps.defaultApplications = {
    "text/plain" = "nvim-wezterm.desktop";
    "text/x-python" = "nvim-wezterm.desktop";
    "text/x-shellscript" = "nvim-wezterm.desktop";
    "application/x-shellscript" = "nvim-wezterm.desktop";
    "application/javascript" = "nvim-wezterm.desktop";
    "text/markdown" = "nvim-wezterm.desktop";
    "text/rust" = "nvim-wezterm.desktop";
    "application/json" = "nvim-wezterm.desktop";
    "application/yaml" = "nvim-wezterm.desktop";

    "text/x-csrc" = "nvim-wezterm.desktop";
    "text/x-chdr" = "nvim-wezterm.desktop";
    "text/x-c++src" = "nvim-wezterm.desktop";
    "text/x-c++hdr" = "nvim-wezterm.desktop";
    "text/x-ocaml" = "nvim-wezterm.desktop";
  };
}
