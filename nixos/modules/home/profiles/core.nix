{ config, lib, ... }: {
  options.features.profiles.core = {
    enable = lib.mkEnableOption "Core profile";
  };

  config = lib.mkIf config.features.profiles.core.enable {
    home.stateVersion = lib.mkDefault "24.11";

    features.system = {
      nix.enable = true;
      home.enable = true;
    };

    features.dotfiles = {
      paths = {
        ".config/nixos" = lib.mkDefault "nixos";
        ".config/easyeffects" = lib.mkDefault "easyeffects";
        ".config/obs-studio" = lib.mkDefault "obs-studio";
      };
    };

    features.persist = {
      directories = { ".vagrant.d" = lib.mkDefault true; };
    };
  };
}
