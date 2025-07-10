{pkgs, ...}: {
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.noto
    font-awesome
    font-manager
  ];

  fonts.fontconfig.enable = true;
}
