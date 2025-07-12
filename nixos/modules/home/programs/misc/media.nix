{
  inputs,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    ffmpeg
    imagemagick
    yt-dlp

    inputs.curd.packages.${pkgs.system}.default

    oculante
    termusic
    youtube-tui
    ani-cli

    mpv
    gimp
    krita
    audacity
    kdePackages.kdenlive
  ];

  features.dotfiles = {
    paths = {
      ".config/curd" = lib.mkDefault "curd";
    };
  };
}
