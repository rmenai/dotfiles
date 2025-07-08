{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./fonts.nix
    ./power.nix
  ];

  programs.waybar.enable = true;
  home.packages = with pkgs; [
    hyprlock
    hyprpaper
    hypridle
    dunst
    libnotify
    pamixer
    brightnessctl

    (rofi-wayland.override {plugins = [pkgs.rofi-emoji-wayland];})
    swaylock-effects
    sddm-sugar-dark
    rofi-emoji-wayland
    hyprpicker
    eww

    slurp
    kdePackages.xwaylandvideobridge
    kdePackages.xdg-desktop-portal-kde
    xdg-desktop-portal
    grim
    flameshot
    qt6.qtwayland
    wl-mirror
    wl-clipboard
    cliphist
    wlogout
    wtype
  ];

  dotfiles = {
    files = {
      ".config/hypr" = lib.mkDefault "hypr";
      ".config/waybar" = lib.mkDefault "waybar";
      ".config/rofi" = lib.mkDefault "rofi";
      ".config/swaylock" = lib.mkDefault "swaylock";
      ".config/dunst" = lib.mkDefault "dunst";
      ".config/cliphist" = lib.mkDefault "cliphist";
    };
  };

  persist = {
    home = {
      # ".local/share/hyprland" = lib.mkDefault true;
      # ".local/share/sddm" = lib.mkDefault true;
      # ".cache/snowflake" = lib.mkDefault true;
    };
  };
}
