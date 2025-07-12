{ pkgs, lib, config, ... }: {
  options.features.apps.browsers.chromium = {
    enable = lib.mkEnableOption "Chromium browser";
  };

  config = lib.mkIf config.features.apps.browsers.chromium.enable {
    home.packages = with pkgs; [ chromium ];

    features.dotfiles = {
      paths = { ".config/chrome" = lib.mkDefault "chrome"; };
    };
  };
}
