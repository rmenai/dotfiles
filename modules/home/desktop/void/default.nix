{ pkgs, ... }:
{
  imports = [
    ./awww.nix
    ./cliphist.nix
    ./mime.nix
    ./niri.nix
    ./rofi.nix
    ./satty.nix
    ./swayidle.nix
    ./swaylock.nix
    ./swaync.nix
    ./swayosd.nix
    ./theme.nix
    ./waybar.nix
    # ./wlsunset.nix
  ];

  home.packages = with pkgs; [
    niri
    wl-clipboard
    brightnessctl
    networkmanager
    pulseaudio
    libnotify
    bluez

    networkmanager_dmenu
    rofi-power-menu
    rofi-bluetooth
    libqalculate
    rofi-calc
    rofimoji

    tesseract
    hyprpicker
    nautilus
  ];

  programs = {
    # niri.enable = true;  Handled by flake
    waybar.enable = true;
    rofi.enable = true;
    satty.enable = true;
    swaylock.enable = true;
  };

  services = {
    cliphist.enable = true;
    swayidle.enable = true;
    swayosd.enable = true;
    swaync.enable = true;
    awww.enable = true;
  };
}
