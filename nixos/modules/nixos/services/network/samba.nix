{ config, lib, ... }:
let
  cfg = config.features.services.samba;
in
{
  options.features.services.samba = {
    enable = lib.mkEnableOption "Samba file sharing";
  };

  config = lib.mkIf cfg.enable {
    services.samba = {
      enable = true;
      securityType = "user";
      settings = {
        global = {
          "workgroup" = "WORKGROUP";
          "server string" = "smbnix";
          "netbios name" = "smbnix";
          "security" = "user";
          "hosts allow" = "192.168.0. 127.0.0.1 localhost";
          "hosts deny" = "0.0.0.0/0";
          "guest account" = "nobody";
          "map to guest" = "bad user";
        };
        "public" = {
          "path" = "/mnt/Shares/Public";
          "browsable" = "yes";
          "read only" = "no";
          "guest ok" = "yes";
          "create mask" = "0644";
          "directory mask" = "0755";
          "force user" = "username";
          "force group" = "groupname";
        };
        "private" = {
          "path" = "/mnt/Shares/Private";
          "browsable" = "yes";
          "read only" = "no";
          "guest ok" = "no";
          "create mask" = "0644";
          "directory mask" = "0755";
          "force user" = "username";
          "force group" = "groupname";
        };
      };
    };

    services.samba-wsdd = {
      enable = true;
    };
  };
}
