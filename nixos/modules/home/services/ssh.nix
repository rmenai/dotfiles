{ config, lib, ... }: {
  options.features.services.ssh = {
    enable = lib.mkEnableOption "SSH client configuration";
  };

  config = lib.mkIf config.features.services.ssh.enable {
    programs.ssh = {
      enable = true;
      controlMaster = "auto";
      controlPath = "/home/${config.spec.user}/.ssh/sockets/S.%r@%h:%p";
      controlPersist = "20m";
      serverAliveCountMax = 3;
      serverAliveInterval = 5;
      hashKnownHosts = true;
      addKeysToAgent = "yes";

      matchBlocks = {
        "default" = {
          host = "github.com";
          identitiesOnly = true;
          identityFile = [ "/home/${config.spec.user}/.ssh/id_ed25519" ];
        };
      };
    };

    features.persist = { directories = { ".ssh" = lib.mkDefault true; }; };
  };
}
