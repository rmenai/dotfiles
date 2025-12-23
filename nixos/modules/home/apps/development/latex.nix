{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.features.apps.development.latex = {
    enable = lib.mkEnableOption "LaTeX and Typst tools";
  };

  config = lib.mkIf config.features.apps.development.latex.enable {
    home.packages = with pkgs; [
      typst
      tinymist
      typstyle
      texlab
    ];
  };
}
