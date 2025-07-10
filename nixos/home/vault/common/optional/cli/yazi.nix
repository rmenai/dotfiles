{
  pkgs,
  lib,
  ...
}: {
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
}
