{
  inputs,
  pkgs,
  config,
  lib,
  ...
}: {
  users.mutableUsers = false;

  users.users.${config.spec.username} = {
    name = config.spec.username;
    home = config.spec.home;
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
    "d /persist/${config.spec.username}/ 0777 root root -"
    "d /persist/home/${config.spec.username} 0700 ${config.spec.username} users -"
  ];

  programs.zsh.enable = true;
  programs.git.enable = true;

  home-manager = {
    extraSpecialArgs = {
      inherit pkgs inputs;
    };

    users.${config.spec.username}.imports = [
      (lib.custom.relativeToRoot "home/${config.spec.username}/${config.spec.hostName}.nix")
    ];
  };
}
