{pkgs, ...}:
with pkgs; let
  R-packages = rWrapper.override {packages = with rPackages; [ggplot2 dplyr xts];};
in {
  home.packages = [
    R-packages
  ];
}
