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
      user = config.spec.user;

      musicDirectory = "/home/${config.spec.user}/Music";

      extraConfig = ''
        audio_output {
          type "pulse"
          name "PulseAudio Output"
        }

        # Add a 'fifo' output for visualizers (like ncmpcpp)
        audio_output {
          type "fifo"
          name "mpd_fifo"
          path "/tmp/mpd.fifo"
          format "44100:16:2"
        }
      '';
    };

    systemd.services.mpd.environment = {
      # https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/609
      XDG_RUNTIME_DIR = "/run/user/1000";
    };

    environment.systemPackages = with pkgs; [ mpc-cli ];

    users.users.${config.spec.user}.extraGroups = [ "mpd" ];
  };
}
