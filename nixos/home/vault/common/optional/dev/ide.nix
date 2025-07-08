{pkgs, ...}: {
  home.packages = with pkgs; [
    jetbrains.pycharm-professional
    jetbrains.rust-rover
    jetbrains.rider
    jetbrains.clion
    jetbrains.webstorm
    jetbrains.datagrip

    evil-helix
  ];
}
