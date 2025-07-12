{ pkgs, lib, config, ... }: {
  options.features.apps.browsers.firefox = {
    enable = lib.mkEnableOption "Firefox browser";
  };

  config = lib.mkIf config.features.apps.browsers.firefox.enable {
    home.packages = with pkgs; [ firefox ];

    features.dotfiles = {
      paths = { ".config/chrome" = lib.mkDefault "chrome"; };
    };
  };
}
