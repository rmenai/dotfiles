{pkgs, ...}: {
  # fonts.fontProfiles = {
  #   enable = true;
  #   monospace = {
  #     family = "JetBrainsMono Nerd Font";
  #     package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
  #   };
  #   regular = {
  #     family = "Fira Sans";
  #     package = pkgs.fira;
  #   };
  # };

  home.packages = with pkgs; [
    jetbrains-mono
    font-awesome
    font-manager
    noto-fonts
  ];
}
