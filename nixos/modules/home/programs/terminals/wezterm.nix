{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    wezterm
  ];

  features.dotfiles = {
    paths = {
      ".config/wezterm" = lib.mkDefault "wezterm";
    };
  };
}
