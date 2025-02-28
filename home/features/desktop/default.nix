{pkgs, ...}: {
  imports = [
    ./wayland.nix
    ./hyprland.nix
    ./browser.nix
    ./fonts.nix
  ];

  home.packages = with pkgs; [
    obsidian
    wezterm
  ];
}
