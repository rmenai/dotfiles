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

      matchBlocks = {
        "*" = {
          controlMaster = "auto";
          controlPath = "/home/${config.spec.user}/.ssh/sockets/S.%r@%h:%p";
          controlPersist = "20m";
          serverAliveCountMax = 3;
          serverAliveInterval = 5;
          hashKnownHosts = true;
          addKeysToAgent = "yes";
        };

        "default" = {
          host = "github.com";
          identitiesOnly = true;
          identityFile = [ "/home/${config.spec.user}/.ssh/id_ed25519" ];
        };
      };
    };
  };
}
