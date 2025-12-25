{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.desktop.mime;
in
{
  options.features.desktop.mime = {
    enable = lib.mkEnableOption "XDG MIME applications configuration";
  };

  config = lib.mkIf cfg.enable {
    xdg = {
      enable = true;
      mimeApps.enable = true;

      desktopEntries."nvim-wezterm" =
        let
          wezterm-nvim-launcher = pkgs.writeShellScriptBin "wezterm-nvim-launcher" ''
            #!/bin/sh
            FILE_PATH="$1"
            DIR_PATH=$(dirname "$FILE_PATH")
            CMD="cd \"$DIR_PATH\" && nvim \"$FILE_PATH\""
            ${pkgs.wezterm}/bin/wezterm cli spawn -- zsh -l -i -c "$CMD"
          '';
        in
        {
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
    };
  };
}
