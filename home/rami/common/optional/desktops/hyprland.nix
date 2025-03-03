{pkgs, ...}: {
  imports = [
    ./fonts.nix
  ];

  programs.waybar.enable = true;
  home.packages = with pkgs; [
    hyprlock
    hyprpaper
    hypridle
    hyprlock
    dunst
    libnotify

    swaylock-effects
    sddm-sugar-dark
    rofi-emoji-wayland
    hyprpicker

    qt6.qtwayland
    wl-mirror
    wl-clipboard
    wlogout
    wtype
  ];
}
