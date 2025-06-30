{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    python311Packages.debugpy
    python311Packages.httpx
    python311Packages.tiktoken
    poethepoet
    python311
    ruff
  ];

  persist = {
    home = {
      # ".cache/pip" = lib.mkDefault true;
      # ".cache/pypoetry" = lib.mkDefault true;
    };
  };
}
