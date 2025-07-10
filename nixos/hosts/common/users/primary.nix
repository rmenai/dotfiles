{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  sops.secrets."keys/vault/nullp/account_hash".neededForUsers = true;
  users.mutableUsers = false;

  spec = {
    user = "vault";
    handle = "rmenai";
    userFullName = "Rami Menai";
    email = "rami@menai.me";
  };

  users.users.${config.spec.user} = {
    name = config.spec.user;
    home = "/home/${config.spec.user}";
    isNormalUser = true;
    description = config.spec.userFullName;
    hashedPasswordFile = config.sops.secrets."keys/vault/nullp/account_hash".path;
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
}
