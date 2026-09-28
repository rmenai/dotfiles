{ pkgs, ... }: {
  virtualisation.waydroid.enable = true;
  virtualisation.waydroid.package = pkgs.waydroid-nftables;

  # Enable clipboard sharing
  environment.systemPackages = with pkgs; [
    wl-clipboard
    python3Packages.pyclip
  ];

  # Run Waydroid extra scripts for arm support (for Notein)
  # nix shell github:nix-community/NUR#repos.ataraxiasjel.waydroid-script -c sudo waydroid-script
  # Nevermind, it isn't necessary, I ended up downloading notein from a mirror and installing with adb
}
