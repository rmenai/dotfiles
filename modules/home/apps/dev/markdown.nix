{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.dev.markdown;
in
{
  options.features.apps.dev.markdown = {
    enable = lib.mkEnableOption "Markdown tools";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.markdownlint-cli ];
  };
}
