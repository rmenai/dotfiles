{ config, pkgs, ... }: {
  sops.secrets."secrets/restic_password" = { };

  environment.systemPackages = with pkgs; [
    rclone
    restic
  ];

  services.restic.backups = {
    kagi = {
      initialize = true;
      repository = "rclone:proton:Backups/kagi";
      passwordFile = config.sops.secrets."secrets/restic_password".path;
      rcloneConfigFile = "/root/rclone.conf";

      pruneOpts = [
        "--keep-daily 7"
        "--keep-weekly 4"
        "--keep-monthly 12"
      ];

      timerConfig = {
        OnCalendar = "03:00";
        Persistent = true;
      };

      paths = [
        "/opt/stacks"
        "/mnt/data"
      ];

      exclude = [
        "/mnt/data/lost+found"
        "**/.Trash-*"
        "**/.cache"
      ];
    };
  };
}
