{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.features.apps.tools.yazi = {
    enable = lib.mkEnableOption "Yazi file manager";
  };

  config = lib.mkIf config.features.apps.tools.yazi.enable {
    home.packages = with pkgs; [
      yazi
      p7zip
      poppler
      jq
      fd
    ];

    features.dotfiles = {
      paths = {
        ".config/yazi" = lib.mkDefault "yazi";
      };
    };
  };
}
