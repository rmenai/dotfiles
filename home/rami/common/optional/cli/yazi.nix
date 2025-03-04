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
}
