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

      extraConfig = ''
        UpdateHostKeys ask
        AddKeysToAgent yes

        Host kali
          HostName kali
          User vault
          IdentityFile /home/${config.spec.user}/.ssh/id_vms
          ForwardAgent yes
          ForwardX11 yes
          ForwardX11Trusted yes

        Host flare
          HostName flare
          User vault
          IdentityFile /home/${config.spec.user}/.ssh/id_vms
          ForwardAgent yes
      '';

      matchBlocks = {
        "default" = {
          host = "github.com";
          identitiesOnly = true;
          identityFile = [ "/home/${config.spec.user}/.ssh/id_null" ];
        };
      };
    };

    features.persist = { directories = { ".ssh" = lib.mkDefault true; }; };
  };
}
