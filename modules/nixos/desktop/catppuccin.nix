{ config, lib, ... }:
let
  cfg = config.features.desktop.catppuccin;
in
{
  options.features.desktop.catppuccin = {
    enable = lib.mkEnableOption "Catppuccin Theme Globally";
  };

  config = lib.mkIf cfg.enable {
    catppuccin = {
      flavor = "mocha";
      accent = "pink";
      enable = true;

      tty.enable = lib.mkForce false;

      sddm = {
        font = "FiraCode Nerd Font";
        fontSize = "24";
      };
    };
  };
}
