{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    wezterm
  ];

  dotfiles = {
    files = {
      ".config/wezterm" = lib.mkDefault "wezterm";
    };
  };
}
