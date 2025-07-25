{ config, lib, ... }: {
  options.features.services.networking.avahi = {
    enable = lib.mkEnableOption "Avahi local DNS sharing";
  };

  config = lib.mkIf config.features.services.networking.avahi.enable {
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      domainName = "local";
      publish = {
        enable = true;
        addresses = true;
        workstation = true;
      };
    };
  };
}
