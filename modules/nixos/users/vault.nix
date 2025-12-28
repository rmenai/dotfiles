{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.users.vault;
in
{
  options.features.users.vault = {
    enable = lib.mkEnableOption "Vault user configuration";

    shell = lib.mkOption {
      type = lib.types.package;
      default = pkgs.bash;
      description = "The shell to use for this user on this host";
    };
  };

  config = lib.mkIf cfg.enable {
    spec = {
      user = "vault";
      handle = "rmenai";
      userFullName = "Rami Menai";
      email = "rami@menai.me";
    };

    users.mutableUsers = false;

    users.users.${config.spec.user} = {
      name = config.spec.user;
      home = "/home/${config.spec.user}";
      createHome = true;
      isNormalUser = true;
      description = config.spec.userFullName;
      hashedPasswordFile = config.sops.secrets."users/${config.spec.user}/password_hash".path;

      shell = cfg.shell;

      extraGroups = [
        "wheel"
        "input"
      ];

      packages = [
        inputs.home-manager.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
    };

    sops.secrets = {
      "users/${config.spec.user}/password_hash".neededForUsers = true;

      "users/${config.spec.user}/age_key" = {
        path = "/home/${config.spec.user}/.config/sops/age/key.txt";
        owner = config.spec.user;
        group = "users";
        mode = "0600";
      };

      "users/${config.spec.user}/ssh_private_key" = {
        path = "/home/${config.spec.user}/.ssh/id_ed25519";
        owner = config.spec.user;
        group = "users";
        mode = "0600";
      };

      "users/${config.spec.user}/ssh_public_key" = {
        path = "/home/${config.spec.user}/.ssh/id_ed25519.pub";
        owner = config.spec.user;
        group = "users";
        mode = "0600";
      };
    };

    systemd.tmpfiles.rules = [
      "d /home/${config.spec.user}/.config 0755 ${config.spec.user} users -"
      "d /home/${config.spec.user}/.config/sops 0755 ${config.spec.user} users -"
      "d /home/${config.spec.user}/.config/sops/age 0755 ${config.spec.user} users -"
      "d /home/${config.spec.user}/.ssh 0700 ${config.spec.user} users -"
    ];
  };
}
