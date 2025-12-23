{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.features.services.mpd = {
    enable = lib.mkEnableOption "MPD";
  };

  config = lib.mkIf config.features.services.mpd.enable {
    services.mpd = {
      enable = true;
      musicDirectory = "/home/${config.spec.user}/Music";

      extraConfig = ''
        audio_output {
          type "pulse"
          name "PulseAudio Output"
        }

        audio_output {
          type "fifo"
          name "mpd_fifo"
          path "/tmp/mpd.fifo"
          format "44100:16:2"
        }
      '';
    };

    home.packages = with pkgs; [
      mpc
      (pkgs.ncmpcpp.override { visualizerSupport = true; })
    ];

    features.dotfiles = {
      paths = {
        ".config/ncmpcpp" = lib.mkDefault "ncmpcpp";
      };
    };
  };
}
