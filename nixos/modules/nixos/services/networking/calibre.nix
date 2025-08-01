{ config, lib, ... }: {
  options.features.services.networking.calibre = {
    enable = lib.mkEnableOption "Calibre-Web Automated";
  };

  config = lib.mkIf config.features.services.networking.calibre.enable {
    systemd.tmpfiles.rules = [
      "d /var/lib/calibre 0755 root root -"
      "d /var/lib/calibre/config 0755 root root -"
      "d /var/lib/calibre/library 0755 root root -"
      "d /var/lib/calibre/ingest 0755 root root -"
    ];

    virtualisation.oci-containers.containers."calibre" = {
      image = "crocodilestick/calibre-web-automated:latest";
      ports = [ "127.0.0.1:8084:8083" ];

      volumes = [
        "/var/lib/calibre/config:/config"
        "/var/lib/calibre/ingest:/cwa-book-ingest"
        "/var/lib/calibre/library:/calibre-library"
      ];
    };

    features.persist = {
      directories = { "/var/lib/calibre" = lib.mkDefault true; };
    };
  };
}
