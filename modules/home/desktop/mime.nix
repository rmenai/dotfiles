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
    };
  };
}
