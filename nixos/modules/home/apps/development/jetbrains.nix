{ config, lib, pkgs, ... }: {
  options.features.apps.development.jetbrains = {
    enable = lib.mkEnableOption "JetBrains IDEs";
  };

  config = lib.mkIf config.features.apps.development.jetbrains.enable {
    home.packages = with pkgs; [
      jetbrains.pycharm-professional
      jetbrains.rust-rover
      jetbrains.rider
      jetbrains.clion
      jetbrains.webstorm
      jetbrains.datagrip
    ];
  };
}
