{
  config,
  lib,
  hostSpec,
  ...
}: let
  homeDir = config.home.homeDirectory;
  username = hostSpec.username;
  domain = hostSpec.domain;
  host = "${username}.${domain}";
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
        host = host;
        hostname = host;
        user = username;
        port = 22;
        identitiesOnly = true;
        identityFile = ["${homeDir}/.ssh/id_rsa"];
      };
    };
  };

  persist = {
    home = {
      ".ssh" = lib.mkDefault true;
    };
  };
}
