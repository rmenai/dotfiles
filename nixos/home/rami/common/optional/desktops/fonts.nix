{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    jetbrains-mono
    font-awesome
    font-manager
    noto-fonts
  ];

  persist = {
    home = {
      ".cache/fontconfig" = lib.mkDefault true;
    };
  };
}
