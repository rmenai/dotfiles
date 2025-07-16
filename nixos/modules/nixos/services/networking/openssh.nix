{ config, lib, pkgs, ... }: {
  options.features.services.networking.openssh = {
    enable = lib.mkEnableOption "OpenSSH server and client configuration";
  };

  config = lib.mkIf config.features.services.networking.openssh.enable {
    services.openssh = {
      enable = true;
      ports = [ 22 ];

      settings = {
        PasswordAuthentication = true;
        PermitRootLogin = "yes";
        StreamLocalBindUnlink = "yes";
        GatewayPorts = "clientspecified";
      };

      hostKeys = [
        {
          path = "/etc/ssh/ssh_host_ed25519_key";
          type = "ed25519";
        }
        {
          path = "/etc/ssh/ssh_host_rsa_key";
          type = "rsa";
          bits = 4096;
        }
      ];
    };

    programs.ssh = {
      startAgent = true;

      enableAskPassword = true;
      askPassword =
        pkgs.lib.mkForce "${pkgs.kdePackages.ksshaskpass.out}/bin/ksshaskpass";

      knownHostsFiles = [
        (pkgs.writeText "custom_known_hosts" ''
          github.com ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl
          github.com ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBEmKSENjQEezOmxkZMy7opKgwFB9nkt5YRrYMjNuG5N87uRgg6CLrbo5wAdT/y6v0mKV0U2w0WZ2YB/++Tpockg=
        '')
      ];
    };

    security.pam = {
      rssh.enable = true;
      services.sudo.rssh = true;
    };

    networking.firewall.allowedTCPPorts = [ 22 ];

    users.users.${config.spec.user}.extraGroups = [ "git" ];

    features.persist = { directories = { "/etc/ssh" = lib.mkDefault true; }; };
  };
}
