{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    blender
  ];

  persist = {
    home = {
      # ".config/blender" = lib.mkDefault true;
    };
  };
}
