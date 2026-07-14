{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bandwhich
    bottom
  ];

  programs.btop = {
    enable = true;
  };

  catppuccin = {
    btop.enable = true;
    bottom.enable = true;
  };
}
