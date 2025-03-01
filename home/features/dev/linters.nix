{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.dev.linters;
in {
  options.features.dev.linters.enable = mkEnableOption "Install linter";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      stylua
      cpplint
      alejandra
      asmfmt
      black
      isort
      clang-tools
      shellharden
      ocamlPackages.ocamlformat
    ];
  };
}
