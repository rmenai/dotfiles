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

  persist = {
    home = {
      ".cache/wezterm" = lib.mkDefault true;
      ".local/share/wezterm" = lib.mkDefault true;
    };
  };
}
