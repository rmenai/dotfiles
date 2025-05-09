{
  config,
  lib,
  ...
}: {
  programs.ssh = {
    enable = true;
    controlMaster = "auto";
    controlPath = "${config.hostSpec.home}/.ssh/sockets/S.%r@%h:%p";
    controlPersist = "20m";
    serverAliveCountMax = 3;
    serverAliveInterval = 5;
    hashKnownHosts = true;
    addKeysToAgent = "yes";

    extraConfig = ''
      UpdateHostKeys ask
      AddKeysToAgent yes

      Host kali
        HostName kali
        User vault
        IdentityFile ${config.hostSpec.home}/.ssh/id_vms
        ForwardAgent yes
        ForwardX11 yes
        ForwardX11Trusted yes

      Host flare
        HostName flare
        User vault
        IdentityFile ${config.hostSpec.home}/.ssh/id_vms
        ForwardAgent yes
    '';

    matchBlocks = {
      "default" = {
        host = "github.com";
        identitiesOnly = true;
        identityFile = ["${config.hostSpec.home}/.ssh/id_null"];
      };
    };
  };

  persist = {
    home = {
      ".ssh" = lib.mkDefault true;
    };
  };
}
