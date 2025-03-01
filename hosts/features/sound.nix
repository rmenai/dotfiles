{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.features.sound;
in {
  options.features.sound.enable = mkEnableOption "Enable sound";
  config = mkIf cfg.enable {
    services.pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
    };

    security.rtkit.enable = true;
    services.pulseaudio.enable = false;
  };
}
