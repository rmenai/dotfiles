{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    yazi
    ffmpeg
    p7zip
    poppler
    imagemagick
    jq
    fd
  ];

  dotfiles = {
    files = {
      ".config/yazi" = lib.mkDefault "yazi";
    };
  };

  persist = {
    home = {
      ".local/state/yazi" = lib.mkDefault true;
    };
  };
}
