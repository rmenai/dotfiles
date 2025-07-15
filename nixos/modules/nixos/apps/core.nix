{ config, lib, pkgs, ... }: {
  options.features.apps.core = { enable = lib.mkEnableOption "Core apps"; };

  config = lib.mkIf config.features.apps.core.enable {
    environment.systemPackages = with pkgs; [ wget curl vim git gh ];
    programs.command-not-found.enable = true;
    programs.zsh.enable = true;
  };
}
