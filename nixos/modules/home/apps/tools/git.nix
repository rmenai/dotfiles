{ config, lib, pkgs, ... }: {
  options.features.apps.tools.git = {
    enable = lib.mkEnableOption "Git version control system";
  };

  config = lib.mkIf config.features.apps.tools.git.enable {
    home.packages = with pkgs; [ git gh ];

    features.dotfiles = { paths = { ".config/git" = lib.mkDefault "git"; }; };
  };
}
