{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.services.mpd;
in
{
  options.features.services.mpd = {
    enable = lib.mkEnableOption "MPD";
  };

  config = lib.mkIf cfg.enable {
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

    home.packages = [ pkgs.mpc ];

    programs.ncmpcpp = {
      enable = true;
      package = pkgs.ncmpcpp.override { visualizerSupport = true; };

      mpdMusicDir = "/home/${config.spec.user}/Music";

      settings = {
        mpd_host = "localhost";
        mpd_port = "6600";

        visualizer_data_source = "/tmp/mpd.fifo";
        visualizer_output_name = "mpd_fifo";
        visualizer_type = "spectrum";
      };
    };
  };
}
