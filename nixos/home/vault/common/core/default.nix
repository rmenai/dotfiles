{
  lib,
  pkgs,
  config,
  ...
}: {
  imports = lib.flatten [
    (map lib.custom.relativeToRoot [
      "modules/common/core"
      "modules/common/features"

      "modules/home/core"
      "modules/home/features"
      "modules/home/profiles"
    ])

    ./git.nix
    ./ssh.nix
    ./mime.nix
  ];

  home = {
    username = lib.mkDefault config.spec.user;
    homeDirectory = lib.mkDefault "/home/${config.spec.user}";
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

  features.dotfiles = {
    paths = {
      ".config/nixos" = lib.mkDefault "nixos";
      ".config/easyeffects" = lib.mkDefault "easyeffects";
      ".config/obs-studio" = lib.mkDefault "obs-studio";
    };
  };

  features.persist = {
    directories = {
      ".vagrant.d" = lib.mkDefault true;
    };
  };
}
