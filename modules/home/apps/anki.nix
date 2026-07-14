{ pkgs, ... }:
{
  home.packages = [ pkgs.anki ];
  catppuccin.anki.enable = true;
}
