{
  services.openssh = {
    enable = true;
    ports = [ 22 ];

    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "prohibit-password";
      MaxAuthTries = 3;
      MaxSessions = 2;
      TCPKeepAlive = "no";
      AllowTcpForwarding = "no";
      AllowAgentForwarding = "no";
      X11Forwarding = false;
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

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICRxuetWNEbgVxkHeHo1+WR+/NDfyMww8Wglpjx3/g0W rami@kari"
  ];
}
