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
      enable = true;

      flavor = "mocha";
      accent = "pink";

      tty.enable = lib.mkForce false;

      sddm = {
        font = "FiraCode Nerd Font";
        fontSize = "24";
      };
    };
  };
}
