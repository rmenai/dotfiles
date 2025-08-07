{ pkgs, lib, config, ... }: {
  options.features.apps.browsers.vivaldi = {
    enable = lib.mkEnableOption "Vivaldi browser";
  };

  config = lib.mkIf config.features.apps.browsers.vivaldi.enable {
    home.packages = with pkgs; [ vivaldi ];
  };
}
