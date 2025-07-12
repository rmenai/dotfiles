{ config, lib, pkgs, ... }: {
  options.features.services.audio.pulseaudio = {
    enable = lib.mkEnableOption "PulseAudio support";
  };

  config = lib.mkIf config.features.services.audio.pulseaudio.enable {
    security.rtkit.enable = true;
    services.pulseaudio = {
      enable = true;
      support32Bit = true;
    };

    users.users.${config.spec.user}.extraGroups = [ "audio" ];
    environment.systemPackages = with pkgs; [ pavucontrol ];
  };
}
