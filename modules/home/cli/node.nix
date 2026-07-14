{ pkgs, ... }: {
  home.packages = [ pkgs.volta ];
  home.sessionPath = [ "~/.volta/bin" ];
}
