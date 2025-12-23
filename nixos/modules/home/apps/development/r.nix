{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.features.apps.development.r = {
    enable = lib.mkEnableOption "R statistical computing environment";
  };

  config = lib.mkIf config.features.apps.development.r.enable {
    home.packages =
      with pkgs;
      let
        R-packages = rWrapper.override {
          packages = with rPackages; [
            ggplot2
            dplyr
            xts
          ];
        };
      in
      [ R-packages ];
  };
}
