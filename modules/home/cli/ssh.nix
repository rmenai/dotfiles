{ config, ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    settings = {
      "*" = {
        ControlMaster = "auto";
        ControlPath = "${config.home.homeDirectory}/.ssh/sockets/S.%r@%h:%p";
        ControlPersist = "20m";
        ServerAliveCountMax = 3;
        ServerAliveInterval = 5;
        HashKnownHosts = true;
        AddKeysToAgent = "yes";
      };

      "github.com" = {
        IdentitiesOnly = true;
        IdentityFile = [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];
      };
    };
  };
}
