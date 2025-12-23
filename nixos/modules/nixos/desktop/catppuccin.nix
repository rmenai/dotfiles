{ config, lib, ... }:
{
  options.features.desktop.catppuccin = {
    enable = lib.mkEnableOption "Catppuccin theme globally";
  };

  config = lib.mkIf config.features.desktop.catppuccin.enable {
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
