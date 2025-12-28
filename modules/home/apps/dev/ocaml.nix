{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.dev.ocaml;
in
{
  options.features.apps.dev.ocaml = {
    enable = lib.mkEnableOption "OCaml development tools";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.opam ];

    xdg.configFile."utop/init.ml".text = ''
      #edit_mode_vi
    '';
  };
}
