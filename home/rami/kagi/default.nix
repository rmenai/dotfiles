{ pkgs, ... }: {
  imports = [ ./core.nix ];
  home.packages = [ pkgs.curl ];
  programs.home-manager.enable = true;
}
