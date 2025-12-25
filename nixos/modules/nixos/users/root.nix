{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.users.root;
  pubSSH = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDDw4/okVV4KIt0XvVU+ecFmhYOVS/ETmDAK04WgN1ic vault@null"
  ];
in
{
  options.features.users.root = {
    enable = lib.mkEnableOption "Root user configuration";

    shell = lib.mkOption {
      type = lib.types.package;
      default = pkgs.bash;
      description = "The shell to use for this user on this host";
    };
  };

  config = lib.mkIf cfg.enable {
    users.users.root = {
      hashedPassword = config.private.secrets.rootPasswordHash;
      openssh.authorizedKeys.keys = pubSSH;
    };
  };
}
