{ config, lib, ... }:
let
  cfg = config.features.services.calibre;
in
{
  options.features.services.calibre = {
    enable = lib.mkEnableOption "Calibre-Web Automated";
  };

  config = lib.mkIf cfg.enable {
    sops.secrets."secrets/calibre" = { };

    systemd.tmpfiles.rules = [
      "d /var/lib/calibre 0755 root root -"
      "d /var/lib/calibre/config 0755 root root -"
      "d /var/lib/calibre/library 0755 root root -"
      "d /var/lib/calibre/ingest 0755 root root -"
    ];

    virtualisation.oci-containers.containers."calibre" = {
      image = "crocodilestick/calibre-web-automated:latest";
      ports = [ "127.0.0.1:8084:8083" ];
      environmentFiles = [ config.sops.secrets."secrets/calibre".path ];

      volumes = [
        "/var/lib/calibre/config:/config"
        "/var/lib/calibre/ingest:/cwa-book-ingest"
        "/var/lib/calibre/library:/calibre-library"
      ];

      extraOptions = [
        "--pull=always"
        "--add-host=amazon.com:0.0.0.0"
        "--add-host=www.amazon.com:0.0.0.0"
        "--add-host=douban.com:0.0.0.0"
        "--add-host=www.douban.com:0.0.0.0"
        "--add-host=scholar.google.com:0.0.0.0"
      ];
    };
  };
}
