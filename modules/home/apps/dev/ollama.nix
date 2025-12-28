{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.dev.ollama;
in
{
  options.features.apps.dev.ollama = {
    enable = lib.mkEnableOption "AI tools and services";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ (pkgs.ollama.override { acceleration = "cuda"; }) ];
  };
}
