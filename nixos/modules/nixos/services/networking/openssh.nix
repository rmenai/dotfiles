{ config, lib, ... }: {
  options.features.services.networking.openssh = {
    enable = lib.mkEnableOption "OpenSSH server and client configuration";
  };

  config = lib.mkIf config.features.services.networking.openssh.enable {
    services.openssh = {
      enable = true;
      ports = [ 22 ];

      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "yes";
        MaxAuthTries = 5;
        MaxSessions = 8;
        LoginGraceTime = 30;
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

    security.pam = {
      rssh.enable = true;
      services.sudo.rssh = true;
    };

    features.persist = { directories = { "/etc/ssh" = lib.mkDefault true; }; };
  };
}
