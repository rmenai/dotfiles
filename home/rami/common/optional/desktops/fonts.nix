{pkgs, ...}: {
  home.packages = with pkgs; [
    jetbrains-mono
    font-awesome
    font-manager
    noto-fonts
  ];
}
