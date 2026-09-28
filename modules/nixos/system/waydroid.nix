{ pkgs, ... }: {
  virtualisation.waydroid.enable = true;
  virtualisation.waydroid.package = pkgs.waydroid-nftables;

  # Enable clipboard sharing
  environment.systemPackages = [ pkgs.wl-clipboard ];

  # Run Waydroid extra scripts for arm support (for Notein)
  # nix shell github:nix-community/NUR#repos.ataraxiasjel.waydroid-script -c sudo waydroid-script
}
