{ config, pkgs, ... }:
{
  users.mutableUsers = false;

  users.users = {
    vault = {
      home = "/home/vault";
      createHome = true;
      isNormalUser = true;
      hashedPasswordFile = config.sops.secrets."users/vault/password_hash".path;

      shell = pkgs.bash;

      extraGroups = [
        "networkmanager"
        "vboxusers"
        "libvirtd"
        "adbusers"
        "scanner"
        "wheel"
        "input"
        "audio"
        "video"
        "kvm"
        "git"
        "lp"
      ];
    };

    root = {
      hashedPassword = config.private.secrets.rootPasswordHash;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDDw4/okVV4KIt0XvVU+ecFmhYOVS/ETmDAK04WgN1ic vault@null"
      ];
    };
  };

  sops.secrets = {
    "users/vault/password_hash".neededForUsers = true;

    "users/vault/age_key" = {
      path = "/home/vault/.config/sops/age/key.txt";
      owner = "vault";
      group = "users";
      mode = "0600";
    };

    "users/vault/ssh_private_key" = {
      path = "/home/vault/.ssh/id_ed25519";
      owner = "vault";
      group = "users";
      mode = "0600";
    };

    "users/vault/ssh_public_key" = {
      path = "/home/vault/.ssh/id_ed25519.pub";
      owner = "vault";
      group = "users";
      mode = "0600";
    };
  };

  systemd.tmpfiles.rules = [
    "d /home/vault/.config 0755 vault users -"
    "d /home/vault/.config/sops 0755 vault users -"
    "d /home/vault/.config/sops/age 0755 vault users -"
    "d /home/vault/.ssh 0700 vault users -"
  ];
}
