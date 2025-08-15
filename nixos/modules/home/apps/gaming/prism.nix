{ config, lib, pkgs, ... }: {
  options.features.apps.gaming.prism = {
    enable = lib.mkEnableOption "Steam gaming platform";
  };

  config = lib.mkIf config.features.apps.gaming.prism.enable {
    home.packages = with pkgs; [ prismlauncher ];
  };
}
