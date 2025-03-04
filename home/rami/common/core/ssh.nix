{
  config,
  lib,
  ...
}: let
  homeDir = config.home.homeDirectory;
in {
  programs.ssh = {
    enable = true;
    controlMaster = "auto";
    controlPath = "${homeDir}/.ssh/sockets/S.%r@%h:%p";
    controlPersist = "20m";
    serverAliveCountMax = 3;
    serverAliveInterval = 5;
    hashKnownHosts = true;
    addKeysToAgent = "yes";

    extraConfig = ''
      UpdateHostKeys ask
    '';

    matchBlocks = {
      "default" = {
        host = "github.com";
        identitiesOnly = true;
        identityFile = ["${homeDir}/.ssh/id_null"];
      };
    };
  };

  persist = {
    home = {
      ".ssh" = lib.mkDefault true;
    };
  };
}
