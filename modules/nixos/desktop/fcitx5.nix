{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.desktop.fcitx;
in
{
  options.features.desktop.fcitx = {
    enable = lib.mkEnableOption "fcitx5";
  };

  config = lib.mkIf cfg.enable {
    i18n.supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "ja_JP.UTF-8/UTF-8"
      "fr_FR.UTF-8/UTF-8"
      "ar_EG.UTF-8/UTF-8"
    ];

    # Japanese keyboard
    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        waylandFrontend = true;

        addons = with pkgs; [
          fcitx5-mozc-ut
          fcitx5-gtk
          qt6Packages.fcitx5-configtool # A GUI to configure Fcitx5
        ];
      };
    };
  };
}
