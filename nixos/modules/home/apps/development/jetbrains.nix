{ config, lib, pkgs, ... }: {
  options.features.apps.development.jetbrains = {
    enable = lib.mkEnableOption "JetBrains IDEs";
  };

  config = lib.mkIf config.features.apps.development.jetbrains.enable {
    home.packages = [
      pkgs.stable.jetbrains.pycharm-professional
      pkgs.stable.jetbrains.rust-rover
      pkgs.stable.jetbrains.rider
      pkgs.stable.jetbrains.clion
      pkgs.stable.jetbrains.webstorm
      pkgs.stable.jetbrains.datagrip
    ];
  };
}
