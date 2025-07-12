{ config, lib, pkgs, ... }: {
  options.features.apps.tools.neofetch = {
    enable = lib.mkEnableOption "Neofetch system information tool";
  };

  config = lib.mkIf config.features.apps.tools.neofetch.enable {
    home.packages = with pkgs; [ neofetch ];
  };
}
