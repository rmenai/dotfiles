{ config, lib, pkgs, ... }: {
  options.features.apps.development.ai = {
    enable = lib.mkEnableOption "AI tools and services";
  };

  config = lib.mkIf config.features.apps.development.ai.enable {
    home.packages = [ (pkgs.ollama.override { acceleration = "cuda"; }) ];

    features.persist = { directories = { ".ollama" = lib.mkDefault true; }; };
  };
}
