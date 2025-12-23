{ config, lib, ... }:
{
  options.features.profiles.core = {
    enable = lib.mkEnableOption "Core profile";
  };

  config = lib.mkIf config.features.profiles.core.enable {
    home.stateVersion = lib.mkDefault "25.11";
  };
}
