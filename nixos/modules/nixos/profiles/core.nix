{ config, lib, ... }: {
  options.features.profiles.core = {
    enable = lib.mkEnableOption "Core profile";
  };

  config = lib.mkIf config.features.profiles.core.enable {
    system.stateVersion = lib.mkDefault "25.11";

    networking = {
      hostName = config.spec.host;

      firewall = {
        enable = true;
        allowPing = true;
        trustedInterfaces = [ "tailscale0" ];
      };
    };

    features = {
      system = {
        nix.enable = true;
        home.enable = true;
        sops.enable = true;
      };

      services.security.fail2ban.enable = true;
      apps.core.enable = true;
    };

    users.users.root.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDDw4/okVV4KIt0XvVU+ecFmhYOVS/ETmDAK04WgN1ic vault@null"
    ];

    security.sudo.extraConfig = ''
      Defaults !tty_tickets # share authentication across all ttys, not one per-tty
      Defaults lecture = never # rollback results in sudo lectures after each reboot
      Defaults timestamp_timeout=120 # only ask for password every 2h
    '';
  };
}
