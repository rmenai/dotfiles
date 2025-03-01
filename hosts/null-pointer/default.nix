{
  imports = [
    ../common
    ../features
    ./configuration.nix
  ];

  features = {
    impermanence.enable = true;
    secure-boot.enable = true;
    tlp.enable = true;
    sound.enable = true;
    printer.enable = true;
  };
}
