{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    obsidian
  ];

  persist = {
    home = {
      # ".config/obsidian" = lib.mkdefault true;
    };
  };
}
