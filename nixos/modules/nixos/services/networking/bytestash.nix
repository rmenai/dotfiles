{ config, lib, ... }: {
  options.features.services.networking.bytestash = {
    enable = lib.mkEnableOption "Code snippet storage";
  };

  config = lib.mkIf config.features.services.networking.bytestash.enable {
    sops.secrets."secrets/bytestash" = { };

    systemd.tmpfiles.rules = [ "d /var/lib/bytestash 0755 root root -" ];

    virtualisation.oci-containers.containers."bytestash" = {
      image = "ghcr.io/jordan-dalby/bytestash:latest";
      ports = [ "127.0.0.1:5000:5000" ];
      volumes = [ "/var/lib/bytestash:/data/snippets" ];
      environmentFiles = [ config.sops.secrets."secrets/bytestash".path ];
      environment = {
        PORT = "5000";
        BASE_PATH = "";
        ALLOW_NEW_ACCOUNTS = "false";
        DISABLE_ACCOUNTS = "false";
        DISABLE_INTERNAL_ACCOUNTS = "false";
      };
    };
  };
}
