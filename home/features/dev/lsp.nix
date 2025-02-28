{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.dev.lsp;
in {
  options.features.dev.lsp.enable = mkEnableOption "Install lsp";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # opam install ocaml-lsp-server
      # rustup component add rust-analyzer
      bash-language-server
      lua-language-server
      pyright
      nixd
    ];
  };
}
