{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.dev.latex;
in
{
  options.features.apps.dev.latex = {
    enable = lib.mkEnableOption "LaTeX and Typst tools";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      typst
      tinymist # Typst LSP
      typstyle
      texlab # LaTeX LSP
    ];
  };
}
