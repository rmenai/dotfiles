{ inputs, ... }:
{
  imports = [
    inputs.catppuccin.homeModules.catppuccin

    ../../modules/home/desktop/void/theme.nix
    ../../modules/home/desktop/void/rofi.nix
    ../../modules/home/apps/brave.nix
  ];

  home = {
    username = "void";
    homeDirectory = "/home/void";
    enableNixpkgsReleaseCheck = false;
    stateVersion = "26.05";
  };

  programs = {
    home-manager.enable = true;
    rofi.enable = true;
  };
}
