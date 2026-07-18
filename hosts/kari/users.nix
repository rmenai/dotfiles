{
  config,
  inputs,
  outputs,
  pkgs,
  ...
}:
{
  home-manager = {
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs outputs pkgs; };
    users.rami = import ../../home/rami/kari;
    users.void = import ../../home/void/kari.nix;
  };

  users.mutableUsers = false;

  users.users = {
    rami = {
      home = "/home/rami";
      createHome = true;
      isNormalUser = true;
      hashedPasswordFile = config.sops.secrets."users/rami/password_hash".path;

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
      # TODO: change root password and add it to proton
      hashedPassword = config.private.rootPasswordHash;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICRxuetWNEbgVxkHeHo1+WR+/NDfyMww8Wglpjx3/g0W rami@kari"
      ];
    };

    void = {
      isNormalUser = true;
      createHome = true;
      hashedPasswordFile = config.sops.secrets."users/void/password_hash".path;

      extraGroups = [
        "networkmanager"
        "video"
        "audio"
      ];
    };
  };

  sops.secrets = {
    "users/void/password_hash".neededForUsers = true;

    "users/rami/password_hash".neededForUsers = true;

    "users/rami/age_key" = {
      path = "/home/rami/.config/sops/age/keys.txt";
      owner = "rami";
      group = "users";
      mode = "0600";
    };

    "users/rami/ssh_private_key" = {
      path = "/home/rami/.ssh/id_ed25519";
      owner = "rami";
      group = "users";
      mode = "0600";
    };

    "users/rami/ssh_public_key" = {
      path = "/home/rami/.ssh/id_ed25519.pub";
      owner = "rami";
      group = "users";
      mode = "0600";
    };
  };

  systemd.tmpfiles.rules = [
    "d /home/rami/.config 0755 rami users -"
    "d /home/rami/.config/sops 0755 rami users -"
    "d /home/rami/.config/sops/age 0755 rami users -"
    "d /home/rami/.ssh 0700 rami users -"
  ];
}
