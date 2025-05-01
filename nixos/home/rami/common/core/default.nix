{
  lib,
  pkgs,
  config,
  ...
}: {
  imports = lib.flatten [
    ../../../../modules/common
    ../../../../modules/home

    ./git.nix
    ./ssh.nix
  ];

  home = {
    username = lib.mkDefault config.hostSpec.username;
    homeDirectory = lib.mkDefault config.hostSpec.home;
    stateVersion = lib.mkDefault "24.11";
  };

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      warn-dirty = false;
    };
  };

  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";

  persist = {
    home = {
      ".vagrant.d" = lib.mkDefault true;
    };
  };

  dotfiles = {
    files = {
      ".config/nixos" = lib.mkDefault "nixos";
    };
  };
}
