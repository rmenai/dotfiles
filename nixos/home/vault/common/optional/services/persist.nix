{
  config,
  lib,
  inputs,
  ...
}: {
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];

  home.persistence."${config.features.impermanence.persistFolder}/home/${config.spec.user}" = {
    allowOther = true;
  };

  home.file = {
    ".adventofcode.session" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.features.impermanence.persistFolder}/home/${config.spec.user}/.adventofcode.session";
      force = true;
    };
  };

  features.persist = {
    directories = {
      "Downloads" = lib.mkDefault true;
      "Music" = lib.mkDefault true;
      "Pictures" = lib.mkDefault true;
      "Documents" = lib.mkDefault true;
      "Videos" = lib.mkDefault true;
      "Public" = lib.mkDefault true;
      "Games" = lib.mkDefault true;
      ".dotfiles" = lib.mkDefault true;
      ".gnupg" = lib.mkDefault true;
      ".nixops" = lib.mkDefault true;
      ".cache" = lib.mkDefault true;
      ".config" = lib.mkDefault true;
      ".local" = lib.mkDefault true;
    };
  };
}
