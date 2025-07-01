{
  inputs,
  pkgs,
  config,
  lib,
  ...
}: {
  sops.secrets."keys/vault/nullp/account_hash".neededForUsers = true;
  users.mutableUsers = false;

  users.users.${config.hostSpec.username} = {
    name = config.hostSpec.username;
    home = config.hostSpec.home;
    isNormalUser = true;
    description = config.hostSpec.userFullName;
    hashedPasswordFile = config.sops.secrets."keys/vault/nullp/account_hash".path;
    packages = [inputs.home-manager.packages.${pkgs.system}.default];
    shell = pkgs.zsh;
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
    "d /persist/${config.hostSpec.username}/ 0777 root root -"
    "d /persist/home/${config.hostSpec.username} 0700 ${config.hostSpec.username} users -"
  ];

  programs.zsh.enable = true;
  programs.git.enable = true;

  home-manager = {
    extraSpecialArgs = {
      inherit pkgs inputs;
    };

    users.${config.hostSpec.username}.imports = [
      (lib.custom.relativeToRoot "home/${config.hostSpec.username}/${config.hostSpec.hostName}.nix")
    ];
  };
}
