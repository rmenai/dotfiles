{
  pkgs,
  lib,
  ...
}: {
  home.packages = [
    (pkgs.ollama.override {
      acceleration = "cuda";
    })
  ];

  persist = {
    home = {
      ".ollama" = lib.mkDefault true;
    };
  };
}
