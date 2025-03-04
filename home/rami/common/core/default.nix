{
  lib,
  pkgs,
  hostSpec,
  inputs,
  ...
}: {
  imports = lib.flatten [
    inputs.sops-nix.homeManagerModules.sops

    (map lib.custom.relativeToRoot [
      "modules/common"
      "modules/home"
    ])

    ./sops.nix
    ./bash.nix
    ./git.nix
    ./ssh.nix

    ./services
  ];

  home = {
    username = lib.mkDefault hostSpec.username;
    homeDirectory = lib.mkDefault hostSpec.home;
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
}
