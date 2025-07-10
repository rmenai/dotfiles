{
  inputs,
  pkgs,
  config,
  lib,
  ...
}: {
  users.mutableUsers = false;

  users.users.${config.spec.user} = {
    name = config.spec.user;
    home = "/home/${config.spec.user}";
    isNormalUser = true;
    description = config.spec.userFullName;
    password = "test";
    packages = [inputs.home-manager.packages.${pkgs.system}.default];
    shell = pkgs.nushell;
    extraGroups = lib.flatten [
      "wheel"
      "input"
      "audio"
      "video"
      "docker"
      "podman"
      "git"
      "networkmanager"
      "tss"
      "libvirtd"
      "vboxusers"
      "scanner"
      "lp"
      "kvm"
      "adbusers"
    ];

    openssh.authorizedKeys.keys = [
      (builtins.readFile ./keys/id_null.pub)
      (builtins.readFile ./keys/id_vms.pub)
    ];
  };

  systemd.tmpfiles.rules = [
    "d ${config.features.impermanence.persistFolder}/${config.spec.user}/ 0777 root root -"
    "d ${config.features.impermanence.persistFolder}/home/${config.spec.user} 0700 ${config.spec.user} users -"
  ];

  programs.zsh.enable = true;
  programs.git.enable = true;

  home-manager = {
    extraSpecialArgs = {
      inherit pkgs inputs;
    };

    users.${config.spec.user}.imports = [
      (lib.custom.relativeToRoot "home/${config.spec.user}/${config.spec.user}.nix")
    ];
  };
}
