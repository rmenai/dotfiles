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

  features.persist = {
    directories = {
      ".ollama" = lib.mkDefault true;
    };
  };
}
