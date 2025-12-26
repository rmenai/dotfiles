{ config, lib, ... }:
let
  cfg = config.features.core.home;
in
{
  options.features.core.home = {
    enable = lib.mkEnableOption "Core home-manager Configuration";
  };

  config = lib.mkIf cfg.enable {
    home = {
      username = config.spec.user;
      homeDirectory = "/home/${config.spec.user}";
      enableNixpkgsReleaseCheck = false;
    };

    programs.home-manager.enable = true;
    systemd.user.startServices = "sd-switch";
  };
}
