{ config, lib, ... }:
let
  cfg = config.features.services.fail2ban;
in
{
  options.features.services.fail2ban = {
    enable = lib.mkEnableOption "Fail2ban support";
  };

  config = lib.mkIf cfg.enable {
    services.fail2ban = {
      enable = true;

      jails = {
        ssh = {
          settings = {
            enabled = true;
            filter = "sshd";
            action = "iptables[name=SSH, port=ssh, protocol=tcp]";
            logpath = "/var/log/auth.log";
            maxretry = 5;
            bantime = "1h";
            findtime = "10m";
          };
        };
      };

      ignoreIP = [
        "127.0.0.1/8"
        "::1"
        "192.168.0.0/16"
        "10.0.0.0/8"
        "172.16.0.0/12"
        "100.64.0.0/10" # Tailscale CGNAT range
      ];
    };
  };
}
