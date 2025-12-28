{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.services.pulseaudio;
in
{
  options.features.services.pulseaudio = {
    enable = lib.mkEnableOption "PulseAudio support";
  };

  config = lib.mkIf cfg.enable {
    security.rtkit.enable = true;

    services = {
      pipewire.enable = false;

      pulseaudio = {
        enable = true;
        support32Bit = true;
      };
    };

    environment.systemPackages = with pkgs; [
      pavucontrol
      pulseaudio
    ];

    users.users.${config.spec.user}.extraGroups = [ "audio" ];
  };
}
