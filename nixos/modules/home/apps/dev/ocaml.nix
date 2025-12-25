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

    features.core.dotfiles.links.utop = "utop";
  };
}
