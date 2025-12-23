{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.features.apps.development.jetbrains = {
    enable = lib.mkEnableOption "JetBrains IDEs";
  };

  config = lib.mkIf config.features.apps.development.jetbrains.enable {
    home.packages = [
      pkgs.jetbrains.pycharm-professional
      pkgs.jetbrains.rust-rover
      pkgs.jetbrains.clion
      pkgs.jetbrains.clion
      pkgs.jetbrains-toolbox
      pkgs.stable.jetbrains.rider
      pkgs.stable.jetbrains.webstorm
      pkgs.stable.jetbrains.datagrip
    ];
  };
}
