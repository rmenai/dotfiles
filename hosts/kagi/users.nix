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
    users.rami = import ../../home/rami/kagi;
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
        "podman"
        "wheel"
        "input"
        "git"
      ];
    };

    root = {
      hashedPassword = config.private.rootPasswordHash;
    };
  };

  sops.secrets = {
    "users/rami/password_hash".neededForUsers = true;

    "users/rami/age_key" = {
      path = "/home/rami/.config/sops/age/keys.txt";
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
