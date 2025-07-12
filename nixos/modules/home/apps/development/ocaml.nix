{ config, lib, pkgs, ... }: {
  options.features.apps.development.ocaml = {
    enable = lib.mkEnableOption "OCaml development tools";
  };

  config = lib.mkIf config.features.apps.development.ocaml.enable {
    home.packages = with pkgs; [ opam ];

    features.dotfiles = { paths = { ".config/utop" = lib.mkDefault "utop"; }; };
    features.persist = { directories = { ".opam" = lib.mkDefault true; }; };
  };
}
