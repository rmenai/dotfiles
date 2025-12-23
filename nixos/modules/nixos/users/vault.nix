{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  options.features.users.vault = {
    enable = lib.mkEnableOption "vault user configuration";
  };

  config = lib.mkIf config.features.users.vault.enable {
    sops.secrets."users/vault/password_hash".neededForUsers = true;
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
      createHome = true;
      isNormalUser = true;
      description = config.spec.userFullName;
      hashedPasswordFile = config.sops.secrets."users/vault/password_hash".path;
      packages = [
        inputs.home-manager.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
      shell = pkgs.nushell;
      extraGroups = lib.flatten [
        "wheel"
        "input"
      ];
    };

    sops.secrets."users/${config.spec.user}/age_key" = {
      path = "/home/${config.spec.user}/.config/sops/age/key.txt";
      owner = config.spec.user;
      group = "users";
      mode = "0600";
    };

    sops.secrets."users/${config.spec.user}/ssh_private_key" = {
      path = "/home/${config.spec.user}/.ssh/id_ed25519";
      owner = config.spec.user;
      group = "users";
      mode = "0600";
    };

    sops.secrets."users/${config.spec.user}/ssh_public_key" = {
      path = "/home/${config.spec.user}/.ssh/id_ed25519.pub";
      owner = config.spec.user;
      group = "users";
      mode = "0600";
    };

    systemd.tmpfiles.rules = [
      "d /home/${config.spec.user}/.config 0755 ${config.spec.user} users -"
      "d /home/${config.spec.user}/.config/sops 0755 ${config.spec.user} users -"
      "d /home/${config.spec.user}/.config/sops/age 0755 ${config.spec.user} users -"
      "d /home/${config.spec.user}/.ssh 0700 ${config.spec.user} users -"
    ];
  };
}
