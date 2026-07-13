{ lib, ... }:
{
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
}
