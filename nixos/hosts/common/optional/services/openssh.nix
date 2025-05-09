{
  services.openssh = {
    enable = true;
    ports = [22];

    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      StreamLocalBindUnlink = "yes";
      GatewayPorts = "clientspecified";
    };

    hostKeys = [
      {
        path = "/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];
  };

  programs.ssh = {
    startAgent = true;
  };

  security.pam = {
    rssh.enable = true;
    services.sudo.rssh = true;
  };

  networking.firewall.allowedTCPPorts = [22];
}
