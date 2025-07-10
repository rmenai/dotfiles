{
  lib,
  pkgs,
  config,
  ...
}: {
  imports = lib.flatten [
    (map lib.custom.relativeToRoot [
      "modules/core"
      "modules/home/core"
    ])

    ./git.nix
    ./ssh.nix
    ./mime.nix
  ];

  home = {
    username = lib.mkDefault config.spec.username;
    homeDirectory = lib.mkDefault config.spec.home;
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

  dotfiles = {
    files = {
      ".config/nixos" = lib.mkDefault "nixos";
      ".config/easyeffects" = lib.mkDefault "easyeffects";
      ".config/obs-studio" = lib.mkDefault "obs-studio";
    };
  };

  persist = {
    home = {
      ".vagrant.d" = lib.mkDefault true;
      # ".config/virt-viewer" = lib.mkDefault true;
      # ".config/VirtualBox" = lib.mkDefault true;
      # ".config/packer" = lib.mkDefault true;
    };
  };
}
