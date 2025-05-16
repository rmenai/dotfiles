{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    python312Packages.debugpy
    python312Packages.httpx
    poethepoet
    python312
    pyright

    black
    isort
  ];

  persist = {
    home = {
      ".cache/pip" = lib.mkDefault true;
      ".cache/pypoetry" = lib.mkDefault true;
    };
  };
}
