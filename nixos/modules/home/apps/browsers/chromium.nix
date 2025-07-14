{ config, lib, pkgs, inputs, ... }: {
  options.features.apps.browsers.chromium = {
    enable = lib.mkEnableOption "Chromium browser";
  };

  config = lib.mkIf config.features.apps.browsers.chromium.enable {
    home.packages = with pkgs; [ chromium ];

    sops.secrets."data" = {
      sopsFile = "${builtins.toString inputs.secrets}/files/surfingkeys.js";
      path = "/home/${config.spec.user}/.config/chrome/surfingkeys.js";
    };

    features.dotfiles = {
      paths = { ".config/chrome" = lib.mkDefault "chrome"; };
    };
  };
}
