{ config, lib, pkgs, ... }: {
  options.features.apps.development.jetbrains = {
    enable = lib.mkEnableOption "JetBrains IDEs";
  };

  config = lib.mkIf config.features.apps.development.jetbrains.enable {
    home.packages = [
      # pkgs.jetbrains.pycharm-professional
      # pkgs.jetbrains.rust-rover
      # pkgs.jetbrains.rider
      # pkgs.jetbrains.clion
      # pkgs.jetbrains.webstorm
      # pkgs.jetbrains.datagrip
    ];
  };
}
