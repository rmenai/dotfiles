{ inputs, lib, pkgs, config, ... }: {
  options.features.apps.misc.media = {
    enable = lib.mkEnableOption "Media applications and tools";
  };

  config = lib.mkIf config.features.apps.misc.media.enable {
    home.packages = [
      pkgs.ffmpeg
      pkgs.imagemagick
      pkgs.yt-dlp

      inputs.curd.packages.${pkgs.system}.default

      pkgs.oculante
      pkgs.termusic
      pkgs.youtube-tui
      pkgs.ani-cli

      pkgs.mpv
      pkgs.stable.gimp
      pkgs.krita
      pkgs.audacity
      pkgs.kdePackages.kdenlive
      pkgs.ncmpcpp
    ];

    xdg.mimeApps.defaultApplications = {
      # Video files - mpv
      "video/mp4" = "mpv.desktop";
      "video/x-msvideo" = "mpv.desktop";
      "video/quicktime" = "mpv.desktop";
      "video/x-matroska" = "mpv.desktop";
      "video/webm" = "mpv.desktop";
      "video/x-flv" = "mpv.desktop";
      "video/x-ms-wmv" = "mpv.desktop";

      # Audio files - mpv
      "audio/mpeg" = "mpv.desktop";
      "audio/mp4" = "mpv.desktop";
      "audio/x-wav" = "mpv.desktop";
      "audio/x-flac" = "mpv.desktop";
      "audio/ogg" = "mpv.desktop";
      "audio/x-vorbis+ogg" = "mpv.desktop";

      # Image files - oculante
      "image/jpeg" = "oculante.desktop";
      "image/png" = "oculante.desktop";
      "image/gif" = "oculante.desktop";
      "image/webp" = "oculante.desktop";
      "image/tiff" = "oculante.desktop";
      "image/bmp" = "oculante.desktop";
      "image/svg+xml" = "oculante.desktop";
    };

    features.dotfiles = {
      paths = {
        ".config/curd" = lib.mkDefault "curd";
        ".config/ncmpcpp" = lib.mkDefault "ncmpcpp";
      };
    };
  };
}
