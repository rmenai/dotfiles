{ config, lib, pkgs, ... }: {
  options.features.system.nix = {
    enable = lib.mkEnableOption "nix configuration for home-manager";
  };

  config = lib.mkIf config.features.system.nix.enable {
    nix = {
      package = lib.mkDefault pkgs.nix;
      settings = {
        experimental-features = [ "nix-command" "flakes" ];
        warn-dirty = false;
      };
    };
  };
}
