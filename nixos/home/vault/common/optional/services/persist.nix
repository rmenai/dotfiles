{
  config,
  lib,
  inputs,
  ...
}: {
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];

  home.persistence."/persist/home/${config.hostSpec.username}" = {
    allowOther = true;
  };

  home.file = {
    ".adventofcode.session" = {
      source = config.lib.file.mkOutOfStoreSymlink "/persist${config.hostSpec.home}/.adventofcode.session";
      force = true;
    };
  };

  persist = {
    home = {
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

      # ".local/share/keyrings" = lib.mkDefault true;
      # ".local/share/direnv" = lib.mkDefault true;
      # ".local/state/home-manager" = lib.mkDefault true;
      # ".local/state/nix" = lib.mkDefault true;
      # ".local/state/containers" = lib.mkDefault true;
      #
      # ".cache/nvidia" = lib.mkDefault true;
      # ".cache/nix" = lib.mkDefault true;
      # ".cache/mesa_shader_cache_db" = lib.mkDefault true;
      # ".cache/mesa_shader_cache" = lib.mkDefault true;
      # ".config/Electron" = lib.mkDefault true;
      # ".config/environment.d" = lib.mkDefault true;
      # ".config/nix" = lib.mkDefault true;
    };
  };
}
