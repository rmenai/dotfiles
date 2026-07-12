{ config, lib, ... }:
let
  cfg = config.features.apps.tools.ssh;
in
{
  options.features.apps.tools.ssh = {
    enable = lib.mkEnableOption "SSH client configuration";
  };

  config = lib.mkIf cfg.enable {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;

      settings = {
        "*" = {
          ControlMaster = "auto";
          ControlPath = "/home/${config.spec.user}/.ssh/sockets/S.%r@%h:%p";
          ControlPersist = "20m";
          ServerAliveCountMax = 3;
          ServerAliveInterval = 5;
          HashKnownHosts = true;
          AddKeysToAgent = "yes";
        };

        "github.com" = {
          IdentitiesOnly = true;
          IdentityFile = [ "/home/${config.spec.user}/.ssh/id_ed25519" ];
        };
      };
    };
  };
}
