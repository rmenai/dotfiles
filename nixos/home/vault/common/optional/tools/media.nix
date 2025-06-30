{pkgs, ...}: {
  home.packages = with pkgs; [
    mpv
    imv
    gimp
    krita
    audacity
    kdePackages.kdenlive
  ];
}
