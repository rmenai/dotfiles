{ config, lib, pkgs, ... }: {
  options.features.apps.core = { enable = lib.mkEnableOption "Core apps"; };

  config = lib.mkIf config.features.apps.core.enable {
    environment = { systemPackages = with pkgs; [ wget git vim ]; };
  };
}
