{ config, lib, pkgs, ... }: {
  options.features.services.monitoring.netdata = {
    enable = lib.mkEnableOption "Netdata configuration";
  };

  config = lib.mkIf config.features.services.monitoring.netdata.enable {
    services.netdata = {
      enable = true;
      package = pkgs.netdata.override { withCloudUi = true; };
    };

    features.persist = { directories = { "/var/lib/netdata" = true; }; };
  };
}
