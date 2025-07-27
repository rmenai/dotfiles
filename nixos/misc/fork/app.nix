{ lib, ... }: {
  users.users.nixos = {
    isNormalUser = true;
    hashedPassword = "";
    shell = "/usr/local/bin/microvm-ssh-wrapper.sh";
    home = "/var/empty";
    createHome = false;
  };

  services.openssh = {
    settings = {
      PermitEmptyPasswords = lib.mkForce true;
      PasswordAuthentication = lib.mkForce true;
    };
    extraConfig = ''
      Match User nixos
          PermitTTY yes
          X11Forwarding no
          AllowAgentForwarding no
          AllowTcpForwarding no
          PermitTunnel no
          PermitUserRC no
          AllowStreamLocalForwarding no
          GatewayPorts no
    '';
  };

  environment.etc."microvm-ssh-wrapper.sh" = {
    text = ''
      #!/usr/bin/env bash
      /run/wrappers/bin/sudo /run/current-system/sw/bin/microvm -r microvm
    '';
    mode = "0755";
  };

  # Create symlink in /usr/local/bin for the SSH ForceCommand
  system.activationScripts.microvm-wrapper = ''
    mkdir -p /usr/local/bin
    ln -sf /etc/microvm-ssh-wrapper.sh /usr/local/bin/microvm-ssh-wrapper.sh
  '';

  # Grant microvm-user sudo access for microvm commands only
  security.sudo.extraRules = [{
    users = [ "nixos" ];
    commands = [{
      command = "/run/current-system/sw/bin/microvm";
      options = [ "NOPASSWD" ];
    }];
  }];
}
